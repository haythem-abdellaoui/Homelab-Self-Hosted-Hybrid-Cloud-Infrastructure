variable "proxmox_api_url" {
  type        = string
  description = "URL de l'API Proxmox VE (ex: https://10.0.0.2:8006/)"
}

variable "proxmox_api_token" {
  type        = string
  description = "Token d'API au format user@realm!tokenid=secret"
  sensitive   = true
}

variable "target_node" {
  type        = string
  default     = "pve"
  description = "Nom du nœud Proxmox"
}

variable "ssh_public_key" {
  type        = string
  description = "Clé SSH publique à injecter via Cloud-Init"
}