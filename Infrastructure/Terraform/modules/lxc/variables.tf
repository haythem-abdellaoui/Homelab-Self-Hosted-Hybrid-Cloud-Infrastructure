# --- Paramètres requis (Obligatoires) ---
variable "target_node" {
  type        = string
  description = "Nom du nœud Proxmox hôte (ex: pve)"
}

variable "vm_id" {
  type        = number
  description = "ID Proxmox du conteneur (ex: 101)"
}

variable "hostname" {
  type        = string
  description = "Nom d'hôte du conteneur LXC"
}

variable "template_id" {
  type        = string
  description = "Identifiant du fichier template LXC (ex: local:vztmpl/debian-12-...)"
}

variable "ip_address" {
  type        = string
  description = "Adresse IP avec masque CIDR (ex: 10.0.10.2/24)"
}

variable "gateway" {
  type        = string
  description = "Passerelle par défaut (ex: 10.0.10.1)"
}

variable "ssh_public_key" {
  type        = string
  description = "Contenu de la clé publique SSH"
}

# --- Paramètres optionnels (Valeurs par défaut) ---
variable "os_type" {
  type        = string
  default     = "debian"
  description = "Type de système d'exploitation"
}

variable "memory" {
  type        = number
  default     = 256
  description = "RAM dédiée en Mo"
}

variable "swap" {
  type        = number
  default     = 256
  description = "Mémoire Swap en Mo"
}

variable "cores" {
  type        = number
  default     = 1
  description = "Nombre de cœurs vCPU"
}

variable "nesting" {
  type        = bool
  default     = true
  description = "Activer le nesting LXC"
}

variable "datastore_id" {
  type        = string
  default     = "local-lvm"
  description = "Nom du stockage Proxmox"
}

variable "disk_size" {
  type        = number
  default     = 8
  description = "Taille du disque en Go"
}

variable "network_interface_name" {
  type        = string
  default     = "eth0"
  description = "Nom de l'interface réseau dans le LXC"
}

variable "bridge" {
  type        = string
  default     = "vmbr0"
  description = "Pont réseau Proxmox"
}

variable "vlan_tag" {
  type        = number
  default     = 10
  description = "ID du VLAN"
}

variable "unprivileged" {
  type        = bool
  default     = true
  description = "Créer un conteneur non-privilégié"
}

variable "started" {
  type        = bool
  default     = true
  description = "Démarrer le conteneur après création"
}