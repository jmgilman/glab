data "vsphere_virtual_machine" "ubuntu18044" {
  name          = "ubuntu18044"
  datacenter_id = data.vsphere_datacenter.gilman.id
}

data "vsphere_virtual_machine" "kube" {
  name          = "kube"
  datacenter_id = data.vsphere_datacenter.gilman.id
}