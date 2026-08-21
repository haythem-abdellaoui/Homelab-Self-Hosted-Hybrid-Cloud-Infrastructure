variable "resource_group_name" {
	type = string
}

variable "location" {
	type = string
}

variable "vnet_name" {
	type    = string
	default = "vnet-globalnet-dev"
}

variable "vnet_cidr" {
	type    = string
	default = "10.0.0.0/16"
}

variable "vm_subnet_cidr" {
	type    = string
	default = "10.0.1.0/24"
}

variable "mysql_subnet_cidr" {
	type    = string
	default = "10.0.2.0/24"
}