#!/bin/bash

#----------------------------------------------------------------
# deploy one or more MAGC Portal services from a single stack
#----------------------------------------------------------------
# each stack of services is expected to have one config file:
#   ./stacks/<stackName>/<stackName>-stack.yml
#----------------------------------------------------------------
# after deployment, the following commands are useful:
#   docker service ls
#   docker service ps <STACK_NAME_SERVICE_NAME>
#   docker service rm <STACK_NAME_SERVICE_NAME>
#   etc.
#----------------------------------------------------------------

# set environment variables
echo "loading environment"
source ../config/server.sh

# get arguments
USAGE="usage: deploy-stack.sh <STACK_NAME> [VERSION]"
STACK_NAME="$1"
STACK_FILE=$PWD/stacks/$STACK_NAME/$STACK_NAME-stack.yml
export VERSION=$2 # optional, needed for app-server

# check stack
if [ "$STACK_NAME" == "" ]; then
    echo "unknown STACK_NAME: $STACK_NAME"
    echo $USAGE
    exit 1
fi
if [ ! -e "$STACK_FILE" ]; then
    echo "missing STACK_FILE: $STACK_FILE"
    echo $USAGE
    exit 1
fi
if [[ "$STACK_NAME" == "app-server" && "$VERSION" == "" ]]; then
    echo "missing VERSION for $STACK_NAME"
    echo $USAGE
    exit 1
fi

# make sure we are logged in to AWS docker registry
bash ../config/docker-registry-login.sh

# deploy/update the requested service stack based on config
# the odd syntax re: DOCKER_REGISTRY is needed to use that variable in image names
export PORTAL_DIR=`realpath $PWD/..` # cannot have .. in a path when deploying
DOCKER_REGISTRY=$DOCKER_REGISTRY docker stack deploy --with-registry-auth -c $STACK_FILE $STACK_NAME

# not relevant to request, but use the opportunity to update a summary file
echo "updating tree.txt"
tree . > tree.txt

echo "done"

