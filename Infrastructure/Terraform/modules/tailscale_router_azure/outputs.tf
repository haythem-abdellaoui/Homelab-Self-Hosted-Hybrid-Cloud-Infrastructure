output "vm_private_ip" {
  description = "Adresse IP privée de la VM Tailscale Router"
  value       = azurerm_network_interface.router_nic.private_ip_address
}

output "vm_id" {
  description = "ID de la VM Azure"
  value       = azurerm_linux_virtual_machine.tailscale_router.id
}