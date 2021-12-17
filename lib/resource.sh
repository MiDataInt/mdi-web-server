# run a user-provided script to download or install resource 
# files into MDI_DIR/resources on the permanent Docker volume

# get ready
cd $MDI_DIR

# file name of the resource script to run in the app-server container
# e.g., 'download-data.sh'
# must be found in the 'resource-scripts' directory
TARGET_SCRIPT=$1

# check target script
TARGET_SCRIPT=resource-scripts/$TARGET_SCRIPT
if [ ! -f "$TARGET_SCRIPT" ]; then
    echo
    echo "unknown target script: $TARGET_SCRIPT"
    echo "usage:"
    echo
    echo "  server resource <TARGET_SCRIPT> ..."
    echo
    echo "where 'TARGET_SCRIPT' is found in 'resource-scripts"
    echo
    exit 1
fi

# go
cd mdi-web-server
docker-compose run \
  --no-deps \
  --rm \
  --volume $MDI_DIR/resource-scripts:/srv/resource-scripts \
   app-server bash get-resource.sh $@
