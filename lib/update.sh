# use an ephemeral apps-server container to
#   - update this server's configuration
docker compose run \
  --no-deps \
  --rm \
  --volume $MDI_DIR/config:/srv/config \
  app-server bash update-config.sh
docker compose restart app-server
