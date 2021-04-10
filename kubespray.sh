#!/usr/bin/env bash

check_error() {
    if [[ $1 -gt 0 ]]
    then
        echo $2
        exit 1
    fi
}

# Clone kubespray repository
echo "Cloning kubespray repository..."
git clone https://github.com/kubernetes-sigs/kubespray
check_error $? "Failed cloning kubespray. Aborting..."

# Install dependencies
echo "Installing Python dependencies..."
sudo pip3 install -r kubespray/requirements.txt

# Copy inventory
echo "Copying inventory..."
cp -rfp inv kubespray/inventory/gilman