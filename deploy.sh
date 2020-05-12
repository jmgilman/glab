#!/usr/bin/env bash

check_error() {
    if [[ $1 -gt 0 ]]
    then
        echo $2
        exit 1
    fi
}
echo "Initiating deployment script..."

# Check for valid Vault token
vault token lookup &> /dev/null
check_error $? "Must have a valid Vault token to deploy!"

# Initialize Terraform
echo "Initializing Terraform..."
terraform init terraform
check_error $? "Error initializing Terraform. Aborting..."

# Destroy existing infrastructure
echo "Destroying infrastructure..."
terraform destroy -auto-approve terraform
check_error $? "Error destroying infrastructure. Aborting..."

# Build master image
echo "Building master image with Packer..."
./packer/build.sh
check_error $? "Error creating master image. Aborting..."

# Apply Terraform config
echo "Applying Terraform configuration..."
terraform apply -auto-approve terraform
check_error $? "Error applying Terraform configuration. Aborting..."

# Setup Kubespray
echo "Setting up Kubespray..."
./kubespray.sh
check_error $? "Error setting up Kubespray. Aborting..."

cd kubespray
# Apply Kubespray config
echo "Applying Kubespray configuration..."
ansible-playbook -i inventory/gilman/inventory.ini --become --become-user=root cluster.yml
check_error $? "Error applying Kubespray config. Aborting..."

echo "Deployment successful!"