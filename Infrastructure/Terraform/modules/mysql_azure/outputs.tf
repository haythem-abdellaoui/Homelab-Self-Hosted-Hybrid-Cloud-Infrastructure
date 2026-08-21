output "mysql_host" {
  value = azurerm_mysql_flexible_server.primary.fqdn
}

output "mysql_user" {
  value = azurerm_mysql_flexible_server.primary.administrator_login
}

output "mysql_password" {
  value     = local.admin_password
  sensitive = true
}

output "database_name" {
  value = azurerm_mysql_flexible_database.db.name
}