#!/bin/bash

# in cases where there is a need to tweak the VS Code Server installation
# this script will bash into the relevant Docker volume where it is installed
# without need of a running web server

VOLUME=mdi-web-server_vscode-server
MOUNT_LOCATION=/root/.vscode-server
DOCKER_IMAGE=mdi-web-server-app-server 

docker run -it --rm \
-v $VOLUME:$MOUNT_LOCATION \
--workdir $MOUNT_LOCATION \
$DOCKER_IMAGE \
bash
