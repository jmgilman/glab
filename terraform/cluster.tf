data "vsphere_compute_cluster" "nucs" {
  name          = "Lab"
  datacenter_id = data.vsphere_datacenter.gilman.id
}