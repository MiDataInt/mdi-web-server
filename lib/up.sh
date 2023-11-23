# launch the MDI apps server on a public web site

# enable server debug mode
DETACH="--detach"
export IS_DEBUG="FALSE"
export IS_DEVELOPER="FALSE"
if [ "$1" != "" ]; then
  DETACH="" # thus, docker compose shows debug app-server log in console
  export IS_DEBUG="TRUE" 
  export N_SERVER_PROCESSES=1
fi
if [[ "$1" == "dev" || "$1" == "develop" || "$1" == "developer" ]]; then
  export IS_DEVELOPER="TRUE" 
fi

# prepare for any potential bind mounts requested by config
sudo mkdir -p /srv/mnt # used in docker-compose.yml
BIND_MOUNT=$MDI_DIR/config/mount.sh
if [ -f "$BIND_MOUNT" ]; then bash $BIND_MOUNT; fi

# launch server
docker compose \
  --env-file ../config/server.sh \
  up \
    --scale app-server=$N_SERVER_PROCESSES \
    --remove-orphans \
    $DETACH
