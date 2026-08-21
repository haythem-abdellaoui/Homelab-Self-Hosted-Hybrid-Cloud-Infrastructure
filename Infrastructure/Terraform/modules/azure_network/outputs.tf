output "vm_subnet_id" {
  value = azurerm_subnet.vm_subnet.id
}

output "mysql_subnet_id" {
  value = azurerm_subnet.mysql_subnet.id
}

output "mysql_private_dns_zone_id" {
  value = azurerm_private_dns_zone.mysql.id
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}