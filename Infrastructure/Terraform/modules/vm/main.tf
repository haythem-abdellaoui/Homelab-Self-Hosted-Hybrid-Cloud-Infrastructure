resource "proxmox_virtual_environment_vm" "vm" {
  name      = var.vm_name
  node_name = var.target_node
  vm_id     = var.vm_id

  # Mode clone depuis la VM Template
  clone {
    vm_id = var.template_id # Ou template_vm_id selon tes variables
  }

  # Agent QEMU
  agent {
    enabled = true
  }

  # Spécifications matérielles
  cpu {
    cores   = var.cores
    sockets = 1
    type    = "host"
  }

  memory {
    dedicated = var.memory
  }

  # Interface réseau
  network_device {
    model   = "virtio"
    bridge  = var.bridge
    vlan_id = var.vlan_id
  }

  # Disque système (redimensionné après clone)
  disk {
    datastore_id = var.storage
    interface    = "scsi0"
    size         = var.disk_size
  }

  # Configuration Cloud-Init
  initialization {
    ip_config {
      ipv4 {
        address = var.ip_address
        gateway = var.gateway
      }
    }

    user_account {
      username = var.ciuser
      keys     = [var.ssh_key]
    }
  }

  # Conserver le bloc lifecycle
  lifecycle {
    ignore_changes = [
      network_device,
      disk,
    ]
  }
}