# Helm

Add the main repo with:

`helm repo add stable https://kubernetes-charts.storage.googleapis.com/`

# Storage

Reference:
* [Persistent volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
* [Storage classes](https://kubernetes.io/docs/concepts/storage/storage-classes/)
* [nfs-client provisioner](https://github.com/kubernetes-incubator/external-storage/tree/master/nfs-client)

The primary form of storage is NFS provided by the vSAN file service. To get dynamic storage for NFS configured, do
the following:

* Create a new file share for the Kubernetes cluster to use
* Ensure you set the IP range to something that includes all the nodes in the cluster
* After creating it, in the configuration section for vSAN file service, select the newly created file share and then
select *Copy URL* -> NFSv4.1
* Take note of the IP address and export path
* Ensure `nfs-common` package is installed on **all** nodes
* Use helm to install the nfs-client provider: 
  * `helm install nfs-storage stable/nfs-client-provisioner --set nfs.server=<server ip> --set nfs.path=<path>`
* Verify the pod starts
* Once everything is up the new storageclass `nfs-client` will be available for dynamic volume creation
  * `kubectl describe storageclass nfs-client`
  
# Load Balancer

Reference:
* [Load balancers](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/)
* [MetalLB](https://metallb.universe.tf/)

To setup MetaLB:

* Enable `strictARP`:
  * `kubectl edit configmap -n kube-system kube-proxy`
* Apply the manifests:
  * `kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml`
  * `kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml`
* If this is the first time installing, generate the secret:
  * `kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"`
* Create the ConfigMap
  * `kubectl create -f loadbalancer.yml`

To use it, assign a service the LoadBalancer type and optionally specify an address pool to assign from:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx
  annotations:
    metallb.universe.tf/address-pool: default
spec:
  ports:
    - port: 80
      targetPort: 80
  selector:
    app: nginx-test-deployment
  type: LoadBalancer
```

Note the above annotation is redundant as not specifying an address-pool will result in the load balancer assigning an
address from the `default` pool.

# cert-manager

Reference:
* [cert-manager](https://cert-manager.io/docs/)

* Create namespace
  * `kubectl create namespace cert-manager`
* Add repo
  * `helm repo add jetstack https://charts.jetstack.io`
  * `helm repo update`
* Install Helm chart
```bash
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v0.15.0 \
  --set installCRDs=true
```
* Create issuer
  * Currently you must manually update the token in the cloudflare secret
  * Create secret: `kubectl create -f cloudflare.yml`
  * Create issuer: `kubectl create -f clusterissuer.yml`