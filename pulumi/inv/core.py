import pulumi
import pulumi_vsphere as vsphere

# Datacenters
datacenter = vsphere.get_datacenter(name="Gilman")

# Clusters
clusters = {
    'lab': vsphere.get_compute_cluster(datacenter_id=datacenter.id, name="Lab")
}

# Hosts
hosts = {}
prefix = 'esxi'
suffix = '.gilman.io'
for i in range(0, 5):
    name = prefix + str(i)
    hosts[name] = vsphere.get_host(datacenter_id=datacenter.id, name=name + suffix)
