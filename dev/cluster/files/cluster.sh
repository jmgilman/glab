#!/usr/bin/env bash

function help {
    echo "Usage: cluster [COMMAND]"
    echo "Commands:"
    echo "  cmd        Run command against node"
    echo "  destroy    Deletes the cluster"
    echo "  down       Stops the cluster"
    echo "  provision  Runs the cluster provisioner"
    echo "  ssh        Connect to node"
    echo "  up         Brings up the cluster"
}

# Parse command
case "$1" in
cmd)
    PWD=$(pwd)
    cd ~/.dev/glab-dev
    vagrant ssh $2 -c $3
    cd ${PWD}
    ;;
destroy)
    PWD=$(pwd)
    cd ~/.dev/glab-dev
    vagrant destroy -f
    cd ${PWD}
    ;;
down)
    PWD=$(pwd)
    cd ~/.dev/glab-dev
    vagrant suspend
    cd ${PWD}
    ;;
provision)
    PWD=$(pwd)
    cd ~/.dev/glab-dev
    vagrant provision
    cd ${PWD}
    ;;
ssh)
    PWD=$(pwd)
    cd ~/.dev/glab-dev
    vagrant ssh $2
    cd ${PWD}
    ;;
up)
    PWD=$(pwd)
    cd ~/.dev/glab-dev
    vagrant up --provider=virtualbox
    cd ${PWD}
    ;;
*)
    help
    exit 1
esac