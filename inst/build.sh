# get ready
export MDI_DIR=$PWD
source config/server.sh
cd mdi-web-server

# go
docker-compose build \
  --build-arg MDI_DIR=$MDI_DIR \
  --build-arg R_VERSION=$R_VERSION \
  --build-arg GITHUB_PAT=$GITHUB_PAT
