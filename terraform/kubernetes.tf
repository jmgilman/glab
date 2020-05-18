resource "vsphere_virtual_machine" "kubem01" {
  name             = "kubem01"
  resource_pool_id = data.vsphere_compute_cluster.nucs.resource_pool_id
  datastore_id     = data.vsphere_datastore.vsan.id
  tags             = [data.vsphere_tag.kubernetes.id, data.vsphere_tag.kubernetes_master.id, data.vsphere_tag.ubuntu.id]

  num_cpus         = 4
  memory           = 8192
  guest_id         = data.vsphere_virtual_machine.ubuntu18044.guest_id
  enable_disk_uuid = true

  network_interface {
    network_id     = data.vsphere_network.orchestration.id
    adapter_type   = data.vsphere_virtual_machine.ubuntu18044.network_interface_types[0]
    use_static_mac = true
    mac_address    = "00:50:56:8a:28:71"
  }

  network_interface {
    network_id     = data.vsphere_network.dev.id
    adapter_type   = data.vsphere_virtual_machine.ubuntu18044.network_interface_types[0]
    use_static_mac = true
    mac_address    = "00:50:56:8a:30:71"
  }

  network_interface {
    network_id     = data.vsphere_network.prod.id
    adapter_type   = data.vsphere_virtual_machine.ubuntu18044.network_interface_types[0]
    use_static_mac = true
    mac_address    = "00:50:56:8a:29:71"
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.ubuntu18044.disks[0].size
    thin_provisioned = data.vsphere_virtual_machine.ubuntu18044.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.kube.id
  }

  extra_config = {
    "guestinfo.metadata" = base64encode(templatefile(
    "${path.module}/templates/metadata.yml",
    {
      hostname = "kubem01"
    }
    ))
    "guestinfo.metadata.encoding" = "base64"
    "guestinfo.userdata" = base64encode(templatefile(
    "${path.module}/templates/init.sh",
    {
      token   = vault_token.init.client_token,
      address = "http://vault.gilman.io:8200"
    }
    ))
    "guestinfo.userdata.encoding" = "base64"
  }
}

resource "vsphere_virtual_machine" "kubem02" {
  name             = "kubem02"
  resource_pool_id = data.vsphere_host.esxi0.resource_pool_id
  datastore_id     = data.vsphere_datastore.optane.id
  tags             = [data.vsphere_tag.kubernetes.id, data.vsphere_tag.kubernetes_master.id, data.vsphere_tag.ubuntu.id]

  num_cpus         = 4
  memory           = 8192
  guest_id         = data.vsphere_virtual_machine.ubuntu18044.guest_id
  enable_disk_uuid = true

  network_interface {
    network_id     = data.vsphere_network.orchestration.id
    adapter_type   = data.vsphere_virtual_machine.ubuntu18044.network_interface_types[0]
    use_static_mac = true
    mac_address    = "00:50:56:8a:28:72"
  }

  network_interface {
    network_id     = data.vsphere_network.dev.id
    adapter_type   = data.vsphere_virtual_machine.ubuntu18044.network_interface_types[0]
    use_static_mac = true
    mac_address    = "00:50:56:8a:30:72"
  }

  network_interface {
    network_id     = data.vsphere_network.prod.id
    adapter_type   = data.vsphere_virtual_machine.ubuntu18044.network_interface_types[0]
    use_static_mac = true
    mac_address    = "00:50:56:8a:29:72"
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.ubuntu18044.disks[0].size
    thin_provisioned = data.vsphere_virtual_machine.ubuntu18044.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.kube.id
  }

  extra_config = {
    "guestinfo.metadata" = base64encode(templatefile(
    "${path.module}/templates/metadata.yml",
    {
      hostname = "kubem02"
    }
    ))
    "guestinfo.metadata.encoding" = "base64"
    "guestinfo.userdata" = base64encode(templatefile(
    "${path.module}/templates/init.sh",
    {
      token   = vault_token.init.client_token,
      address = "http://vault.gilman.io:8200"
    }
    ))
    "guestinfo.userdata.encoding" = "base64"
  }
}

resource "vsphere_virtual_machine" "kubew-medium" {
  count = 3

  name             = "kubew0${count.index + 1}"
  resource_pool_id = data.vsphere_compute_cluster.nucs.resource_pool_id
  datastore_id     = data.vsphere_datastore.vsan.id
  tags             = [data.vsphere_tag.kubernetes.id, data.vsphere_tag.kubernetes_master.id, data.vsphere_tag.ubuntu.id]

  num_cpus         = 4
  memory           = 8192
  guest_id         = data.vsphere_virtual_machine.ubuntu18044.guest_id
  enable_disk_uuid = true

  network_interface {
    network_id     = data.vsphere_network.orchestration.id
    adapter_type   = data.vsphere_virtual_machine.ubuntu18044.network_interface_types[0]
    use_static_mac = true
    mac_address    = "00:50:56:8a:28:8${count.index + 1}"
  }

  network_interface {
    network_id     = data.vsphere_network.dev.id
    adapter_type   = data.vsphere_virtual_machine.ubuntu18044.network_interface_types[0]
    use_static_mac = true
    mac_address    = "00:50:56:8a:30:8${count.index + 1}"
  }

  network_interface {
    network_id     = data.vsphere_network.prod.id
    adapter_type   = data.vsphere_virtual_machine.ubuntu18044.network_interface_types[0]
    use_static_mac = true
    mac_address    = "00:50:56:8a:29:8${count.index + 1}"
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.ubuntu18044.disks[0].size
    thin_provisioned = data.vsphere_virtual_machine.ubuntu18044.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.kube.id
  }

  extra_config = {
    "guestinfo.metadata" = base64encode(templatefile(
    "${path.module}/templates/metadata.yml",
    {
      hostname = "kubew0${count.index + 1}"
    }
    ))
    "guestinfo.metadata.encoding" = "base64"
    "guestinfo.userdata" = base64encode(templatefile(
    "${path.module}/templates/init.sh",
    {
      token   = vault_token.init.client_token,
      address = "http://vault.gilman.io:8200"
    }
    ))
    "guestinfo.userdata.encoding" = "base64"
  }
}

resource "vsphere_virtual_machine" "kubew-large" {
  count = 2

  name             = "kubew0${count.index + 4}"
  resource_pool_id = data.vsphere_host.esxi0.resource_pool_id
  datastore_id     = data.vsphere_datastore.optane.id
  tags             = [data.vsphere_tag.kubernetes.id, data.vsphere_tag.kubernetes_master.id, data.vsphere_tag.ubuntu.id]

  num_cpus         = 8
  memory           = 16384
  guest_id         = data.vsphere_virtual_machine.ubuntu18044.guest_id
  enable_disk_uuid = true

  network_interface {
    network_id     = data.vsphere_network.orchestration.id
    adapter_type   = data.vsphere_virtual_machine.ubuntu18044.network_interface_types[0]
    use_static_mac = true
    mac_address    = "00:50:56:8a:28:8${count.index + 4}"
  }

  network_interface {
    network_id     = data.vsphere_network.dev.id
    adapter_type   = data.vsphere_virtual_machine.ubuntu18044.network_interface_types[0]
    use_static_mac = true
    mac_address    = "00:50:56:8a:30:8${count.index + 4}"
  }

  network_interface {
    network_id     = data.vsphere_network.prod.id
    adapter_type   = data.vsphere_virtual_machine.ubuntu18044.network_interface_types[0]
    use_static_mac = true
    mac_address    = "00:50:56:8a:29:8${count.index + 4}"
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.ubuntu18044.disks[0].size
    thin_provisioned = data.vsphere_virtual_machine.ubuntu18044.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.kube.id
  }

  extra_config = {
    "guestinfo.metadata" = base64encode(templatefile(
    "${path.module}/templates/metadata.yml",
    {
      hostname = "kubew0${count.index + 4}"
    }
    ))
    "guestinfo.metadata.encoding" = "base64"
    "guestinfo.userdata" = base64encode(templatefile(
    "${path.module}/templates/init.sh",
    {
      token   = vault_token.init.client_token,
      address = "http://vault.gilman.io:8200"
    }
    ))
    "guestinfo.userdata.encoding" = "base64"
  }
}
