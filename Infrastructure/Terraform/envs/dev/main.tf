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