# use an ephemeral apps-server container to
#   - install the MDI
#   - update this server's configuration

# set and export environment variable UPDATE_MDI_MANAGER to force mdi-manager to update
#   export UPDATE_MDI_MANAGER=true
# this is not commonly necessary since mdi::install and mdi::run are quite stable
# most often, a dependency update will force mdi-manager to re-install, not changes to mdi-manager itself
# see also MANAGER_INSTALL_HOOK in mdi-apps-server/Dockerfile to force an update at image build

docker compose run \
  --no-deps \
  --rm \
  --volume $MDI_DIR/config:/srv/config \
  app-server bash install-mdi.sh
