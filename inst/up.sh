# get ready
export MDI_DIR=$PWD
source config/server.sh
cd mdi-web-server

# go
sudo docker-compose \
  --env-file ../config/server.env \
  up \
    -d \
    --scale app-server=$N_SERVER_PROCESSES
