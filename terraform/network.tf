data "vsphere_network" "dev" {
  name          = "Dev"
  datacenter_id = data.vsphere_datacenter.gilman.id
}

data "vsphere_network" "management" {
  name          = "Management"
  datacenter_id = data.vsphere_datacenter.gilman.id
}

data "vsphere_network" "media" {
  name          = "Media"
  datacenter_id = data.vsphere_datacenter.gilman.id
}

data "vsphere_network" "orchestration" {
  name          = "Orchestration"
  datacenter_id = data.vsphere_datacenter.gilman.id
}

data "vsphere_network" "prod" {
  name          = "Prod"
  datacenter_id = data.vsphere_datacenter.gilman.id
}

data "vsphere_network" "storage" {
  name          = "Storage"
  datacenter_id = data.vsphere_datacenter.gilman.id
}

data "vsphere_network" "wifi" {
  name          = "Wifi"
  datacenter_id = data.vsphere_datacenter.gilman.id
}