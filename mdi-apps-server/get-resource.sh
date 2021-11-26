# initialize pipelines framework helper functions
source $MDI_DIR/frameworks/definitive/mdi-pipelines-framework/pipeline/workflow/workflow.sh

# launch the script to download or create the target resource
RESOURCE_SCRIPT_NAME=$1
source ../resource-scripts/$RESOURCE_SCRIPT_NAME
