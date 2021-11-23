#!/bin/bash

# remove dangerous code from magc-portal-apps not applicable to server mode

PORTAL_DIR=/srv/magc-portal
DEV_TOOLS_DIR=$PORTAL_DIR/magc-portal-apps/shiny/shared/optional/modules/developerTools

rm -rf $DEV_TOOLS_DIR/fileEditor
rm -rf $DEV_TOOLS_DIR/gitManager
rm -rf $DEV_TOOLS_DIR/sandbox
rm -f  $DEV_TOOLS_DIR/developerTools_server.R
rm -f  $DEV_TOOLS_DIR/developerTools_ui.R

