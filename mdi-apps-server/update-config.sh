# this script runs in an apps-server container to update the server config files
# expects that a working server is built and installed

# copy in the up-to-date config files
cp -r /srv/config/* $MDI_DIR/config
