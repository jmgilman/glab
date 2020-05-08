#!/usr/bin/env bash

# Set vSphere variables
export VMWARE_SERVER="vcenter.gilman.io"
export VMWARE_USERNAME="$(vault kv get -field=username secret/vsphere/api)"
export VMWARE_PASSWORD="$(vault kv get -field=password secret/vsphere/api)"