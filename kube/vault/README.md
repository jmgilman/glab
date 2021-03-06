# Installation

* Create namespace:
  * `kubectl create namespace vault`
* Add Consul repo: 
  * `helm repo add hashicorp https://helm.releases.hashicorp.com`
  * `helm repo update`
* Install Consul:
  * `helm install consul hashicorp/consul -n vault -f helm-consul.yml`
* Add AWS credentials to enable S3 storage and KMS decryption
  * kubectl create secret generic aws-api -n vault \
    --from-literal=access_key=${AWS_SECRET_ACCESS_KEY} \
    --from-literal=access_key_id=${AWS_ACCESS_KEY_ID}
* Add Vault helm repo:
  * `helm repo add banzaicloud-stable http://kubernetes-charts.banzaicloud.com/branch/master`
  * `helm repo update`
* Install Vault:
  * `helm install vault banzaicloud-stable/vault -n vault -f helm-vault.yml`
* Create ingresses:
  * `kubectl create -n vault -f consul-ingress.yml`
  * `kubectl create -n vault -f vault-ingress.yml`
  
# Restoring

* Install Consul
* Forward Consul locally
  * `kubectl port-forward service/consul-server 8500:8500 -n vault`
* Restore the snapshot
  * `consul snapshot restore backup.snap`
* Install Vault
* Create ingresses
* Validate the Vault cluster is operating