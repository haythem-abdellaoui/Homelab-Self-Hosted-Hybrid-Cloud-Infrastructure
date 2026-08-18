output "mysql_host" {
  value = azurerm_mysql_flexible_server.primary.fqdn
}

output "mysql_user" {
  value = azurerm_mysql_flexible_server.primary.administrator_login
}

output "mysql_password" {
  value     = random_password.password.result
  sensitive = true
}

output "database_name" {
  value = azurerm_mysql_flexible_database.db.name
}