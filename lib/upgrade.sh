# install all updated system libraries and security patches

# shut down any running server by stopping its containers
docker compose \
  --env-file ../config/server.sh \
  down

# fetch the new libraries
sudo apt-get update

# install them
sudo apt-get upgrade
