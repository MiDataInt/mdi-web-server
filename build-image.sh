#!/bin/bash

#----------------------------------------------------------------
# build a Docker image for a MAGC Portal service to use
# the required code and assets are generally in ./stacks/<stackName>/...
#----------------------------------------------------------------

# set environment variables
echo "loading environment"
source ../config/server.sh

# get arguments
USAGE="usage: build-image.sh <CONTEXT_DIR> <VERSION>"
CONTEXT_DIR="$1"
VERSION="$2"
if [ "$CONTEXT_DIR" = "" ]; then
    echo "missing argument: CONTEXT_DIR"
    echo $USAGE
    exit 1
fi
if [ ! -d "$CONTEXT_DIR" ]; then
    echo "not a directory: $CONTEXT_DIR"
    echo $USAGE
    exit 1
fi
if [ "$VERSION" = "" ]; then
    echo "missing argument: VERSION"
    echo $USAGE
    exit 1
fi

# set derived values
SERVICE_NAME="$(basename $CONTEXT_DIR)" 
DOCKER_FILE=$CONTEXT_DIR/Dockerfile
IMAGE_NAME=magc-portal/$SERVICE_NAME
LOG_DIR=$PWD/../logs
mkdir -p $LOG_DIR
LOG_FILE="$LOG_DIR/$SERVICE_NAME.build.log"
if [ ! -e "$DOCKER_FILE" ]; then
    echo "Dockerfile not found: $DOCKER_FILE"
    echo $USAGE
    exit 1
fi

# make sure we are logged in to AWS docker registry
bash ../config/docker-registry-login.sh

# build, tag and push the app image
MAGC_PORTAL_SERVER_DIR=$PWD
cd $CONTEXT_DIR
echo "building image: $IMAGE_NAME:$VERSION"
# TODO: remove GITHUB_PAT once magc-portal and magc-portal-apps are public
docker build -t $IMAGE_NAME:$VERSION \
    --build-arg GITHUB_PAT=$GITHUB_PAT \
    --build-arg WEB_DOMAIN=$WEB_DOMAIN \
    --build-arg VERSION=$VERSION . | tee $LOG_FILE
docker tag $IMAGE_NAME:$VERSION $DOCKER_REGISTRY/$IMAGE_NAME:$VERSION
if [ "$DOCKER_REGISTRY" != "" ]; then
    docker push $DOCKER_REGISTRY/$IMAGE_NAME:$VERSION
fi

# not relevant to request, but use the opportunity to update a summary file
cd $MAGC_PORTAL_SERVER_DIR
echo "updating tree.txt"
tree . > tree.txt

echo "done"

