resource "vsphere_virtual_machine" "kubew01" {
  name             = "kubew01"
  resource_pool_id = data.vsphere_compute_cluster.nucs.resource_pool_id
  datastore_id     = data.vsphere_datastore.vsan.id
  tags             = [data.vsphere_tag.kubernetes.id, data.vsphere_tag.kubernetes_worker.id, data.vsphere_tag.ubuntu.id]

  num_cpus         = 4
  memory           = 8192
  guest_id         = data.vsphere_virtual_machine.ubuntu18044.guest_id

  network_interface {
    network_id     = data.vsphere_network.orchestration.id
    adapter_type   = data.vsphere_virtual_machine.ubuntu18044.network_interface_types[0]
    use_static_mac = true
    mac_address    = "00:50:56:8a:28:80"
  }

  disk {
    label = "disk0"
    size  = data.vsphere_virtual_machine.ubuntu18044.disks[0].size
    thin_provisioned = data.vsphere_virtual_machine.ubuntu18044.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu18044.id

    customize {
      linux_options {
        host_name = "kubew01"
        domain = "gilman.io"
      }

      network_interface {
      }
    }
  }
}

resource "vsphere_virtual_machine" "kubew02" {
  name             = "kubew02"
  resource_pool_id = data.vsphere_compute_cluster.nucs.resource_pool_id
  datastore_id     = data.vsphere_datastore.vsan.id
  tags             = [data.vsphere_tag.kubernetes.id, data.vsphere_tag.kubernetes_worker.id, data.vsphere_tag.ubuntu.id]

  num_cpus         = 4
  memory           = 8192
  guest_id         = data.vsphere_virtual_machine.ubuntu18044.guest_id

  network_interface {
    network_id     = data.vsphere_network.orchestration.id
    adapter_type   = data.vsphere_virtual_machine.ubuntu18044.network_interface_types[0]
    use_static_mac = true
    mac_address    = "00:50:56:8a:28:82"
  }

  disk {
    label = "disk0"
    size  = data.vsphere_virtual_machine.ubuntu18044.disks[0].size
    thin_provisioned = data.vsphere_virtual_machine.ubuntu18044.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu18044.id

    customize {
      linux_options {
        host_name = "kubew02"
        domain = "gilman.io"
      }

      network_interface {
      }
    }
  }
}

resource "vsphere_virtual_machine" "kubew03" {
  name             = "kubew03"
  resource_pool_id = data.vsphere_compute_cluster.nucs.resource_pool_id
  datastore_id     = data.vsphere_datastore.vsan.id
  tags             = [data.vsphere_tag.kubernetes.id, data.vsphere_tag.kubernetes_worker.id, data.vsphere_tag.ubuntu.id]

  num_cpus         = 4
  memory           = 8192
  guest_id         = data.vsphere_virtual_machine.ubuntu18044.guest_id

  network_interface {
    network_id     = data.vsphere_network.orchestration.id
    adapter_type   = data.vsphere_virtual_machine.ubuntu18044.network_interface_types[0]
    use_static_mac = true
    mac_address    = "00:50:56:8a:28:84"
  }

  disk {
    label = "disk0"
    size  = data.vsphere_virtual_machine.ubuntu18044.disks[0].size
    thin_provisioned = data.vsphere_virtual_machine.ubuntu18044.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu18044.id

    customize {
      linux_options {
        host_name = "kubew03"
        domain = "gilman.io"
      }

      network_interface {
      }
    }
  }
}

resource "vsphere_virtual_machine" "kubew04" {
  name             = "kubew04"
  resource_pool_id = data.vsphere_host.esxi0.resource_pool_id
  datastore_id     = data.vsphere_datastore.optane.id
  tags             = [data.vsphere_tag.kubernetes.id, data.vsphere_tag.kubernetes_worker.id, data.vsphere_tag.ubuntu.id]

  num_cpus         = 8
  memory           = 12288
  guest_id         = data.vsphere_virtual_machine.ubuntu18044.guest_id

  network_interface {
    network_id     = data.vsphere_network.orchestration.id
    adapter_type   = data.vsphere_virtual_machine.ubuntu18044.network_interface_types[0]
    use_static_mac = true
    mac_address    = "00:50:56:8a:28:86"
  }

  disk {
    label = "disk0"
    size  = data.vsphere_virtual_machine.ubuntu18044.disks[0].size
    thin_provisioned = data.vsphere_virtual_machine.ubuntu18044.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu18044.id

    customize {
      linux_options {
        host_name = "kubew04"
        domain = "gilman.io"
      }

      network_interface {
      }
    }
  }
}

resource "vsphere_virtual_machine" "kubew05" {
  name             = "kubew05"
  resource_pool_id = data.vsphere_host.esxi0.resource_pool_id
  datastore_id     = data.vsphere_datastore.optane.id
  tags             = [data.vsphere_tag.kubernetes.id, data.vsphere_tag.kubernetes_worker.id, data.vsphere_tag.ubuntu.id]

  num_cpus         = 8
  memory           = 12288
  guest_id         = data.vsphere_virtual_machine.ubuntu18044.guest_id

  network_interface {
    network_id     = data.vsphere_network.orchestration.id
    adapter_type   = data.vsphere_virtual_machine.ubuntu18044.network_interface_types[0]
    use_static_mac = true
    mac_address    = "00:50:56:8a:28:88"
  }

  disk {
    label = "disk0"
    size  = data.vsphere_virtual_machine.ubuntu18044.disks[0].size
    thin_provisioned = data.vsphere_virtual_machine.ubuntu18044.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu18044.id

    customize {
      linux_options {
        host_name = "kubew05"
        domain = "gilman.io"
      }

      network_interface {
      }
    }
  }
}