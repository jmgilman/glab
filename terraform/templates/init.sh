#!/usr/bin/env bash
export VAULT_ADDR="${address}"
export VAULT_TOKEN="${token}"

types=(rsa dsa ecdsa ed25519)

rm /etc/ssh/ssh_host*
ssh-keygen -A
for t in $${types[@]}; do
    pub_key="$(cat /etc/ssh/ssh_host_$${t}_key.pub)"
    signed_key="$(vault write -field=signed_key /ssh-host/sign/lab cert_type=host public_key="$pub_key")"
    echo $signed_key > "/etc/ssh/ssh_host_$${t}_key-cert.pub"
done