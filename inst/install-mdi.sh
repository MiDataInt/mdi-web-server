# get ready
export MDI_DIR=$PWD
source config/server.sh
cd mdi-web-server

# go
docker-compose run \
  --no-deps \
  --rm \
  --volume $MDI_DIR/config:/srv/config \
  app-server bash install-mdi.sh
