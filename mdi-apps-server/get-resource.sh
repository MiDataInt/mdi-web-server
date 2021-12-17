# this script helps run other scripts, found in 'resource-scripts',
# that download or otherwise install resources into MDI_DIR/resources

# it runs in a ephemeral app-server instance so that it has
# access to this MDI installation's permanent Docker volume

# initialize pipelines framework helper functions
source $MDI_DIR/frameworks/definitive/mdi-pipelines-framework/pipeline/workflow/workflow.sh

# declare a function to download a file
# do NOT check for existence, some URLs may fail
# preserve source files names
function wgetFile {
    FOLDER=$1   # where to put the downloaded file; could be absolute, or relative to cwd
    FILE=$2     # name of the file on the remote server, and our copy of it
    URL_BASE=$3 # the remote url prefix before the filename
    URL=$URL_BASE/$FILE
    echo
    echo $URL
    wget --no-verbose -O $FOLDER/$FILE $URL
    checkPipe
}

# launch the script to download or create the target resource
TARGET_SCRIPT=$1
source ../resource-scripts/$TARGET_SCRIPT
