# Installation

Perform the following:
* Add Consul repo: 
  * `helm repo add hashicorp https://helm.releases.hashicorp.com`
  * `helm repo update`
* Install Consul
  * `helm install consul hashicorp/consul -n vault -f helm-consul.yml`
* Install the Vault operator
  * `helm repo add banzaicloud-stable https://kubernetes-charts.banzaicloud.com`
  * `helm repo update`
  * `helm upgrade --install vault-operator banzaicloud-stable/vault-operator`