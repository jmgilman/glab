data "vsphere_tag_category" "lab" {
  name = "Lab"
}

data "vsphere_tag" "docker" {
  name        = "Docker"
  category_id = data.vsphere_tag_category.lab.id
}

data "vsphere_tag" "kubernetes" {
  name        = "Kubernetes"
  category_id = data.vsphere_tag_category.lab.id
}

data "vsphere_tag" "kubernetes_master" {
  name        = "Kubernetes_master"
  category_id = data.vsphere_tag_category.lab.id
}

data "vsphere_tag" "kubernetes_worker" {
  name        = "Kubernetes_worker"
  category_id = data.vsphere_tag_category.lab.id
}

data "vsphere_tag" "ubuntu" {
  name        = "Ubuntu"
  category_id = data.vsphere_tag_category.lab.id
}