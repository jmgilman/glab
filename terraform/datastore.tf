data "vsphere_datastore" "containers" {
  name          = "Containers"
  datacenter_id = data.vsphere_datacenter.gilman.id
}

data "vsphere_datastore" "lab" {
  name          = "Lab"
  datacenter_id = data.vsphere_datacenter.gilman.id
}

data "vsphere_datastore" "local" {
  name          = "Local"
  datacenter_id = data.vsphere_datacenter.gilman.id
}

data "vsphere_datastore" "logs" {
  name          = "Logs"
  datacenter_id = data.vsphere_datacenter.gilman.id
}

data "vsphere_datastore" "optane" {
  name          = "Optane"
  datacenter_id = data.vsphere_datacenter.gilman.id
}

data "vsphere_datastore" "vsan" {
  name          = "vsanDatastore"
  datacenter_id = data.vsphere_datacenter.gilman.id
}