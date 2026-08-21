resource "azurerm_public_ip" "router_public_ip" {
  name                = "pip-tailscale-router"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}


resource "azurerm_network_interface" "router_nic" {
  name                = "nic-tailscale-router"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_forwarding_enabled = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address
    public_ip_address_id = azurerm_public_ip.router_public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "tailscale_router" {
  name                = "vm-tailscale-router"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B2s_v2"
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.router_nic.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}


# 1. Créer le Security Group
resource "azurerm_network_security_group" "router_nsg" {
  name                = "nsg-tailscale-router"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "10.228.186.33"
    destination_address_prefix = "*"
  }
}

# 2. Associer le NSG à l'interface réseau (NIC) de la VM
resource "azurerm_network_interface_security_group_association" "router_nic_assoc" {
  network_interface_id      = azurerm_network_interface.router_nic.id
  network_security_group_id = azurerm_network_security_group.router_nsg.id
}