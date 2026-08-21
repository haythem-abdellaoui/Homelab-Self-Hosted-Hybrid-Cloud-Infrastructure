locals {
  # Définition des 2 Load Balancers avec leurs attributs respectifs
  load_balancers = {
    "lb-01" = {
      vm_id = 101
      ip    = "10.0.10.2/24"
    }
    "lb-02" = {
      vm_id = 102
      ip    = "10.0.10.3/24"
    }
  }
}

# Déploiement des Load Balancers via le module réutilisable
module "load_balancers" {
  source   = "../../modules/lxc"
  for_each = local.load_balancers

  # Paramètres obligatoires
  target_node    = var.target_node
  vm_id          = each.value.vm_id
  hostname       = each.key
  template_id    = "local:vztmpl/debian-12-standard_12.12-1_amd64.tar.zst" 
  ip_address     = each.value.ip
  gateway        = "10.0.10.1" 
  ssh_public_key = var.ssh_public_key

  bridge   = "vmbr1"
  vlan_tag = 10

  # Paramètres optionnels (tu peux surcharger les defaults du module si besoin)
  memory       = 256
  swap         = 256
  cores        = 1
  datastore_id = "local-lvm"
  disk_size    = 8
}

# Deploiement des 3 K3s Servers 
module "k3s_nodes" {
  source = "../../modules/vm"
  count  = 3

  vm_name     = "k3s-node-0${count.index + 1}"
  vm_id       = 201 + count.index
  template_id = var.k3s_template_id
  target_node = "pve"
  
  # Configuration Matérielle & Réseau
  memory      = 1536
  bridge      = "vmbr1"
  vlan_id     = 20
  
  # IPs VLAN 20
  ip_address  = "10.0.20.2${count.index + 1}/24"
  gateway     = "10.0.20.1"
  
  ssh_key     = file("~/.ssh/id_ed25519.pub")
}

# Azure

# 1. Le Resource Group (s'il n'est pas déjà géré ailleurs)
resource "azurerm_resource_group" "rg" {
  name     = "rg-globalnet-dev"
  location = "swedencentral"
}

# 2. Le VNet et ses Subnets (votre réseau virtuel)
module "network" {
  source              = "../../modules/azure_network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

# 3. La BDD MySQL (reliée au subnet dédié)
module "mysql_azure" {
  source              = "../../modules/mysql_azure"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = "globalnet-mysql-dev"
  db_name             = "globalnet_db"
  admin_username      = "globalnetadmin"
  admin_password      = var.db_password
  delegated_subnet_id = module.network.mysql_subnet_id
  private_dns_zone_id = module.network.mysql_private_dns_zone_id

  depends_on = [module.network]
}

# 4. Le Tailscale Router (relié au subnet VM)
module "tailscale_router_azure" {
  source              = "../../modules/tailscale_router_azure"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  subnet_id           = module.network.vm_subnet_id
  admin_username      = "azureuser"
  ssh_public_key      = var.ssh_public_key

  depends_on = [module.mysql_azure]
}


# Monitoring LXC 
module "monitoring_lxc" {
  source = "../../modules/monitoring_lxc" 

  # Paramètres obligatoires
  target_node    = "pve"                             # Nom de ton nœud Proxmox
  vm_id          = 401                               
  hostname       = "monitoring-lxc"
  template_id    = "local:vztmpl/debian-12-standard_12.12-1_amd64.tar.zst"
  ip_address     = "10.0.40.10/24"                   # IP statique dans le sous-réseau du VLAN 40
  gateway        = "10.0.40.1"                    # Passerelle du VLAN 40
  ssh_public_key = file("~/.ssh/id_ed25519.pub")

  # Ajustements pour le LXC de Monitoring
  os_type   = "debian" 
  memory    = 1024     # 1 GB RAM pour tenir la stack VictoriaMetrics + Grafana
  swap      = 512
  cores     = 1
  disk_size = 8

  # Réseau & Isolement VLAN
  bridge   = "vmbr1"
  vlan_tag = 40        # Placement direct dans le VLAN 40
}