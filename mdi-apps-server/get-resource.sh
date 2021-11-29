# this script helps run other scripts, found in 'resource-scripts',
# that download or otherwise install resources into MDI_DIR/resources

# it runs in a ephemeral app-server instance so that it has
# access to this MDI installation's permanent Docker volume

# initialize pipelines framework helper functions
source $MDI_DIR/frameworks/definitive/mdi-pipelines-framework/pipeline/workflow/workflow.sh

# launch the script to download or create the target resource
RESOURCE_SCRIPT_NAME=$1
source ../resource-scripts/$RESOURCE_SCRIPT_NAME
