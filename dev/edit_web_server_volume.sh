#!/bin/bash

# in cases where a critical R code error crashes the web server and prevents 
# it from restarting, thus preventing Dev Container: Attach to Running Container,
# this script will bash into the MDI directory on the Docker volume where code is installed
# running "nano .../file.R" allows the error to be corrected in situ 
# without need of a running web server

VOLUME=mdi-web-server_mdi-dir
MOUNT_LOCATION=/srv/mdi
DOCKER_IMAGE=mdi-web-server-app-server 

docker run -it --rm \
-v $VOLUME:$MOUNT_LOCATION \
--workdir $MOUNT_LOCATION \
$DOCKER_IMAGE \
bash
