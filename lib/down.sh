# shut down any running server by stopping its containers
docker compose \
  --env-file ../config/server.sh \
  down
