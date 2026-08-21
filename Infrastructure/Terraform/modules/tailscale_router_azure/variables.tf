variable "resource_group_name" {
  description = "Nom du Resource Group Azure"
  type        = string
}

variable "location" {
  description = "Région Azure pour le déploiement"
  type        = string
}

variable "subnet_id" {
  description = "L'ID du Subnet VNet dans lequel placer la VM"
  type        = string
}

variable "admin_username" {
  description = "Nom d'utilisateur administrateur SSH"
  type        = string
  default     = "azureuser"
}

variable "vm_size" {
  description = "Taille de la VM Azure pour le routeur Tailscale"
  type        = string
  default     = "Standard_B2s"
}

variable "ssh_public_key" {
  description = "Clé SSH publique à injecter via Cloud-Init"
  type        = string
}

variable "private_ip_address" {
  description = "Adresse IP privée statique de la VM routeur"
  type        = string
  default     = "10.0.1.4"
}