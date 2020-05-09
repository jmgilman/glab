# Assumes VSPHERE_USER, VSPHERE_PASSWORD, and VSPHERE_SERVER are defined
provider "vsphere" {
  # Allow self-signed certificates
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "gilman" {
  name = "Gilman"
}