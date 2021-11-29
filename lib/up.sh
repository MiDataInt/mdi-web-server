# launch the MDI apps server on a public web site

# enable server debug mode
DETACH="--detach"
export IS_DEBUG="FALSE"
if [ "$1" != "" ]; then
  DETACH="" # thus, docker-compose shows debug app-server log in console
  export IS_DEBUG="TRUE" 
fi

# launch server
docker-compose \
  --env-file ../config/server.sh \
  up \
    --scale app-server=$N_SERVER_PROCESSES \
    --remove-orphans \
    $DETACH
