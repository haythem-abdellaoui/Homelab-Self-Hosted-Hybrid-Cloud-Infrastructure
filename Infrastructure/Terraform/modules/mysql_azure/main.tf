resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_mysql_flexible_server" "primary" {
  name                   = var.server_name
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  administrator_login    = var.admin_username
  administrator_password = random_password.password.result

  sku_name = var.sku_name
  version  = "8.0.21"

  storage {
    size_gb = var.storage_gb
  }

  backup_retention_days = 7
}

resource "azurerm_mysql_flexible_database" "db" {
  name                = var.db_name
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.primary.name
  charset             = "utf8mb4"
  collation           = "utf8mb4_unicode_ci"
}

resource "azurerm_mysql_flexible_server_firewall_rule" "allow_azure" {
  name                = "AllowAllAzureServices"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.primary.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}