variable "resource_group_name" {
	type = string
}

variable "location" {
	type    = string
	default = "France Central"
}

variable "server_name" {
	type = string
}

variable "db_name" {
	type = string
}

variable "admin_username" {
	type    = string
	default = "globalnetadmin"
}

variable "admin_password" {
	type      = string
	default   = null
	sensitive = true
}

variable "delegated_subnet_id" {
	type = string
}

variable "private_dns_zone_id" {
	type = string
}

variable "sku_name" {
	type    = string
	default = "B_Standard_B1ms"
}

variable "storage_gb" {
	type    = number
	default = 20
}