#!/bin/bash

# called within an app-server AWS instance to execute
# 'pull-code-repositories.sh' in all running app-server containers
# (thus, this script is NOT needed in the Dockerfile or containers themselves)

docker ps |
grep app-server |
awk '{print $1}' | # yields a stream of app-server container ids
xargs -I CONTAINER docker exec -i CONTAINER bash pull-code-repositories.sh 

