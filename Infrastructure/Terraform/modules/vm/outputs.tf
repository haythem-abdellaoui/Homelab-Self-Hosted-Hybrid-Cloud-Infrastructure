output "vm_id" {
  description = "L'ID de la VM"
  value       = proxmox_virtual_environment_vm.vm.vm_id
}

output "vm_name" {
  description = "Nom de la VM"
  value       = proxmox_virtual_environment_vm.vm.name
}

output "vm_ip" {
  description = "Adresse IP de la VM"
  value       = var.ip_address
}