# use an ephemeral apps-server container to
#   - install the MDI
#   - update this server's configuration
docker compose run \
  --no-deps \
  --rm \
  --volume $MDI_DIR/config:/srv/config \
  app-server bash install-mdi.sh
