resource "vsphere_virtual_machine" "kubem01" {
  name             = "kubem01"
  resource_pool_id = data.vsphere_compute_cluster.nucs.resource_pool_id
  datastore_id     = data.vsphere_datastore.vsan.id
  tags             = [data.vsphere_tag.kubernetes.id, data.vsphere_tag.kubernetes_master.id, data.vsphere_tag.ubuntu.id]

  num_cpus         = 4
  memory           = 8092
  guest_id         = data.vsphere_virtual_machine.ubuntu18044.guest_id

  network_interface {
    network_id     = data.vsphere_network.orchestration.id
    adapter_type   = data.vsphere_virtual_machine.ubuntu18044.network_interface_types[0]
    use_static_mac = true
    mac_address    = "00:50:56:8a:28:70"
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
        host_name = "kubem01"
        domain = "gilman.io"
      }

      network_interface {
      }
    }
  }
}