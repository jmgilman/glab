data "vsphere_host" "esxi0" {
  name          = "esxi0.gilman.io"
  datacenter_id = data.vsphere_datacenter.gilman.id
}

data "vsphere_host" "esxi1" {
  name          = "esxi1.gilman.io"
  datacenter_id = data.vsphere_datacenter.gilman.id
}

data "vsphere_host" "esxi2" {
  name          = "esxi2.gilman.io"
  datacenter_id = data.vsphere_datacenter.gilman.id
}

data "vsphere_host" "esxi3" {
  name          = "esxi3.gilman.io"
  datacenter_id = data.vsphere_datacenter.gilman.id
}

data "vsphere_host" "esxi4" {
  name          = "esxi4.gilman.io"
  datacenter_id = data.vsphere_datacenter.gilman.id
}

data "vsphere_resource_pool" "esxi0_pool" {
  name          = "esxi0.gilman.io/Resources"
  datacenter_id = data.vsphere_datacenter.gilman.id
}