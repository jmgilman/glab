data "vsphere_compute_cluster" "nucs" {
  name          = "NUCs"
  datacenter_id = data.vsphere_datacenter.gilman.id
}