# get ready
source config/server.env
cd mdi-web-server

# go
sudo docker-compose \
  --env-file ../config/server.env \
  up \
    -d \
    --scale whoami=$N_SERVER_PROCESSES
