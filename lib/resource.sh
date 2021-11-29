# run a user-provided script to download or install resource 
# files into MDI_DIR/resources on the permanent Docker volume

# get ready
cd $MDI_DIR

# file name of the resource script to run in the app-server container
# e.g., 'download-data.sh'
# must be found in the 'resource-scripts' directory
RESOURCE_SCRIPT_NAME=$1

# check target script
TARGET_SCRIPT=resource-scripts/$RESOURCE_SCRIPT_NAME
if [ ! -f "$TARGET_SCRIPT" ]; then
    echo
    echo "unknown target script: $TARGET_SCRIPT"
    echo "usage:"
    echo
    echo "  ./get-resource.sh <script-name.sh> ..."
    echo
    echo "where 'script-name.sh' is found in 'resource-scripts"
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
