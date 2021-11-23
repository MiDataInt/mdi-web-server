#!/bin/bash

# called within a running app-server container to pull updates of
# the magc-portal-xxx code repositories on their current branches
# thus, executes hotfixes and rolling updates

PORTAL_DIR=/srv/magc-portal

REPO=magc-portal-apps
echo "pulling $REPO"
cd $PORTAL_DIR/$REPO
git pull --ff-only # there should never be any local changes in code

REPO=magc-portal-pipelines
echo "pulling $REPO"
cd $PORTAL_DIR/$REPO
git pull --ff-only

# remove dangerous code from magc-portal-apps not applicable to server mode
bash $PORTAL_DIR/purge-developer-tools.sh

