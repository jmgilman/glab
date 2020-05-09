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
packer build -var-file=packer/vars.json -var "playbook=ansible/common.yml" -force -on-error=ask packer/master.json
check_error $? "Error creating master image. Aborting..."

# Apply Terraform config
echo "Applying Terraform configuration..."
terraform apply -auto-approve terraform
check_error $? "Error applying Terraform configuration. Aborting..."

cd ansible

# Install Ansible roles
echo "Installing Ansible roles..."
ansible-galaxy install -r requirements.yml
check_error $? "Error installing Ansible roles from Galaxy. Aborting..."

# Apply Ansible config
echo "Applying Ansible configuration..."
ansible-playbook --extra-vars '{"force_ssh_host": true}' kube.yml
check_error $? "Error applying Ansible config. Aborting..."

echo "Deployment successful!"