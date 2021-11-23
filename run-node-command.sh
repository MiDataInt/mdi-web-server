#!/bin/bash

# run an arbitrary command on a specific node's bash shell via ssh
USAGE="usage: bash run-node-command.sh <HOSTNAME> <COMMAND> [arguments]"

HOSTNAME=$1
shift
 
if [ "$HOSTNAME" = "" ]; then
    echo "missing HOSTNAME"
    echo $USAGE
    exit 1
fi
if [ "$1" = "" ]; then
    echo "missing COMMAND"
    echo $USAGE
    exit 1
fi

ssh -i ~/.ssh/magc-portal-rsa $HOSTNAME $@

