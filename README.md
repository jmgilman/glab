# The Gilman Lab

The Gilman Lab (glab) is a homelab environment geared at practicing development and operations (devops) methodologies.
This repository serves as the monorepo for storing configuration and infrastructure as code files. Currently, the four
primary technologies at play are Packer, Terraform, Ansible, and Kubernetes. The rest of this README is dedicated to
explaining the structure of the repository.

## Development

The `dev` folder contains the scripts and Ansible playbooks necessary to bootstrap a machine with the necessary
configuration and applications to interact with glab. The files are broken up depending on the system they are aimed
at configuring. The bash script will bootstrap Ansible and the playbook performs all configuration. Dotfiles as well as
SSH client configuration are configured with the playbook. Of note is the `~/.devenv` which declares all of the env
variables that are needed to run Packer, Terraform, and Ansible.

## Base Images (Packer)

The `packer` directory contains the configuration files for building the base vSphere templates from which the rest of the
infrastructure is built on. Currently, this consists of:

* ubuntu18044: A basic installation of Ubuntu 18.04.4
* kube: A basic installation of Ubuntu 18.04.4 with no swap enabled

All base images are stored in the `images` folder on vSphere and is where Terraform expects to find them when deploying
the images. The `build.sh` script inside the directory can be used to build all configured images.

## Deployment (Terraform/Cloud-init)

The `terraform` directory contains the configuration files for deploying the machines which make up glab. This currently
only consists of a bare Kubernetes cluster. The required master and worker nodes will be deployed across the lab cluster
as well as the larger capacity server. The directory contains configurations for all of the assets found in the vSphere
environment. This includes storage, networking, clusters, and images. In the future these resources will be created
automatically, however in the current state they are expected to be present. 

The terraform deployment process expects the environment variables defined in `~/.devenv` to be present as well as
a valid Vault token in `VAULT_TOKEN` and Vault server in `VAULT_ADDR`. The Terraform deployment process will configure
the machines with a cloud-init configuration which sets the hostname as well as signs SSH host certificates. The
machines are given a small TTL token (20 minutes) which they use to sign their SSH host certificates before booting up.
This reduces the toil of having to manually validate fingerprints before signing keys. 

## Deployment (Ansible)

The Kubernetes cluster is configured using Kubespray. The master `deploy.sh` will perform the necessary steps to clone
the Kubespray repo and move over the inventory files. Currently, Kubespray is configured to setup five worker nodes and
two master nodes. Additionally, vSphere CNS is configured for providing persistent storage volumes to pods. 