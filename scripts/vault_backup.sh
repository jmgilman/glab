#!/usr/bin/env bash

echo "Port forwarding consul server..."
kubectl port-forward service/consul-server 8500:8500 -n vault &
FORWARD_PID=$!
sleep 2

echo "Snapshotting..."
export CONSUL_HTTP_ADDR="http://localhost:8500"
consul snapshot save backup.snap

echo "Stopping port forwarding..."
kill ${FORWARD_PID}

echo "Saving backup to S3..."
aws s3 mv backup.snap s3://glab-vault/backup

echo "Done!"