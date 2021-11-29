# build all required Docker images
docker-compose build \
  --build-arg MDI_DIR=$MDI_DIR \
  --build-arg R_VERSION=$R_VERSION \
  --build-arg GITHUB_PAT=$GITHUB_PAT
