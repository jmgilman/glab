#!/usr/bin/env bash

function help {
    echo "Usage: vault.sh [COMMAND]"
    echo "Commands:"
    echo "  backup   - Snapshots the Consul service and saves it to Amazon S3"
    echo "  restore  - Downloads snapshot from S3 and restores to Consul service"
}

function checkForError {
    if [[ $1 -gt 0 ]]; then
        echo "Error: $2"
        exit 1
    fi
}

function pre-req {
    # Check for AWS CLI
    command -v aws &> /dev/null
    checkForError $? "the AWS CLI tool must be installed"

    # Check for Consul
    command -v consul &> /dev/null
    checkForError $? "the Consul CLI tool must be installed"

    # Check environment
    if [[ -z "${AWS_DEFAULT_REGION}" ]]; then
        echo "Error: AWS_DEFAULT_REGION must be set"
    fi
    if [[ -z "${AWS_ACCESS_KEY_ID}" ]]; then
        echo "Error: AWS_ACCESS_KEY_ID must be set"
    fi
    if [[ -z "${AWS_SECRET_ACCESS_KEY}" ]]; then
        echo "Error: AWS_SECRET_ACCESS_KEY must be set"
    fi

    # Check kubernetes
    kubectl get service consul-server -n vault &> /dev/null
    checkForError $? "no service 'consul-server' found in 'vault' namespace"
}

function backup {
    echo "Port forwarding consul server..."
    kubectl port-forward service/consul-server 8500:8500 -n vault &
    FORWARD_PID=$!
    sleep 2

    echo "Taking snapshot..."
    export CONSUL_HTTP_ADDR="http://localhost:8500"
    consul snapshot save backup.snap

    echo "Stopping port forwarding..."
    kill ${FORWARD_PID} &> /dev/null

    echo "Saving backup to S3..."
    aws s3 mv backup.snap s3://glab-vault/backup

    echo "Done!"
}

function restore {
    echo "Port forwarding consul server..."
    kubectl port-forward service/consul-server 8500:8500 -n vault &
    FORWARD_PID=$!
    sleep 2

    echo "Fetching backup..."
    aws s3 cp s3://glab-vault/backup backup.snap

    echo "Restoring snapshot..."
    consul snapshot restore backup.snap

    echo "Stopping port forwarding..."
    kill ${FORWARD_PID} &> /dev/null

    rm backup.snap
    echo "Done!"
}

# Check pre-requisites
pre-req

# Parse command
case "$1" in
backup)
    backup
    ;;
restore)
    restore
    ;;
*)
    help
    exit 1
esac