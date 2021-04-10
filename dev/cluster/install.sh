#!/usr/bin/env bash

KUBESPRAY_URL="https://github.com/kubernetes-sigs/kubespray.git"

echo "Removing existing dev space..."
rm -rf "$HOME/.dev"

echo "Creating dev space..."
mkdir -p "$HOME/.dev/glab-dev"

echo "Pulling down kubespray..."
git clone ${KUBESPRAY_URL} "$HOME/.dev/glab-dev"

echo "Copying custom files..."
mkdir -p "$HOME/.dev/glab-dev/vagrant"

# Custom inventory
cp -r ../../inv/dev "$HOME/.dev/glab-dev/inventory/glab-dev"
mv "$HOME/.dev/glab-dev/inventory/glab-dev/inventory.ini" "$HOME/.dev/glab-dev/inventory/glab-dev/hosts.ini"

# Vagrant files
cp files/config.rb "$HOME/.dev/glab-dev/vagrant"
cp files/Vagrantfile "$HOME/.dev/glab-dev"

# Custom launcher
cp files/cluster.sh "$HOME/bin/cluster"