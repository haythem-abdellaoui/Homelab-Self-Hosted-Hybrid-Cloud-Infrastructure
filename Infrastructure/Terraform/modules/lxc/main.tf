resource "proxmox_virtual_environment_container" "this" {
  node_name    = var.target_node
  vm_id        = var.vm_id
  unprivileged = var.unprivileged
  started      = var.started

  initialization {
    hostname = var.hostname

    ip_config {
      ipv4 {
        address = var.ip_address
        gateway = var.gateway
      }
    }

    user_account {
      keys = [var.ssh_public_key]
    }
  }

  operating_system {
    template_file_id = var.template_id
    type             = var.os_type
  }

  memory {
    dedicated = var.memory
    swap      = var.swap
  }

  cpu {
    cores = var.cores
  }

  features {
    nesting = var.nesting
  }

  disk {
    datastore_id = var.datastore_id
    size         = var.disk_size
  }

  network_interface {
    name    = var.network_interface_name
    bridge  = var.bridge
    vlan_id = var.vlan_tag
  }
}