# Setup
* Create the Consul namespace
  * `kubectl create namespace consul`
* Generate the gossip encryption secret
  * `kubectl create secret generic consul-gossip-encryption-key --from-literal=key=$(consul keygen) -n consul`
* Install the Consul Helm chart
  * `helm install consul-test hashicorp/consul -n consul -f values.yml`