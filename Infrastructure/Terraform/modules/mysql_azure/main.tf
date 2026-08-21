resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

locals {
  admin_password = coalesce(var.admin_password, random_password.password.result)
}

resource "azurerm_mysql_flexible_server" "primary" {
  name                   = var.server_name
  resource_group_name     = var.resource_group_name
  location                = var.location
  administrator_login     = var.admin_username
  administrator_password  = local.admin_password
  delegated_subnet_id     = var.delegated_subnet_id
  private_dns_zone_id     = var.private_dns_zone_id
  public_network_access   = "Disabled"

  sku_name = var.sku_name
  version  = "8.0.21"

  storage {
    size_gb = var.storage_gb
  }

  backup_retention_days = 7

  depends_on = [
    random_password.password,
  ]
}

resource "azurerm_mysql_flexible_database" "db" {
  name                = var.db_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.primary.name
  charset             = "utf8mb4"
  collation           = "utf8mb4_unicode_ci"
}