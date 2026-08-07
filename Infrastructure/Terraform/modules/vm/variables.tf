variable "target_node" {
  description = "Le nœud Proxmox sur lequel déployer la VM"
  type        = string
  default     = "pve"
}

variable "vm_name" {
  description = "Nom de la machine virtuelle"
  type        = string
}

variable "vm_id" {
  description = "L'ID unique de la VM dans Proxmox"
  type        = number
}

variable "template_id" {
  description = "ID de la VM template Cloud-Init a cloner"
  type        = number
}

variable "cores" {
  description = "Nombre de cœurs CPU"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Quantité de RAM en Mo"
  type        = number
  default     = 1536 # 1.5 GB
}

variable "storage" {
  description = "Nom du datastore Proxmox pour le disque"
  type        = string
  default     = "local-lvm"
}

variable "disk_size" {
  description = "Taille du disque en Gio (ex: 15)"
  type        = number
  default     = 15
}

variable "bridge" {
  description = "Le bridge réseau Proxmox"
  type        = string
  default     = "vmbr1"
}

variable "vlan_id" {
  description = "L'ID du VLAN"
  type        = number
  default     = 20
}

variable "ip_address" {
  description = "Adresse IP CIDR de la VM (ex: 10.0.20.21/24)"
  type        = string
}

variable "gateway" {
  description = "Passerelle par défaut du réseau"
  type        = string
}

variable "ssh_key" {
  description = "Clé publique SSH à injecter via Cloud-Init"
  type        = string
}

variable "ciuser" {
  description = "Utilisateur administrateur Cloud-Init"
  type        = string
  default     = "debian"
}