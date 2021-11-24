# get ready
source config/server.env
cd mdi-web-server

# go
sudo docker-compose build \
  --build-arg R_VERSION=$R_VERSION \
  --build-arg GIT_USER=$GIT_USER \
  --build-arg GITHUB_PAT=$GITHUB_PAT
