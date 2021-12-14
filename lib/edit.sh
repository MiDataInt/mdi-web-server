# use nano to edit one of the server configuration files

# help information
function show_usage {
    echo
    echo "!!! $1 !!!"
    echo
    echo "usage:  ./server edit <CONFIG_FILE>"
    echo
    echo "where CONFIG_FILE is one of:"
    echo "    server.sh             server configuration metadata"
    echo "    suites.yml            pipelines and apps suites to install"
    echo "    stage1-pipelines.yml  system defaults for pipeline execution"
    echo "    stage2-apps.yml       access control options for the apps server"
    echo
    exit 1
}

# get ready
export MDI_DIR=$PWD

# check for valid file
if [ "$1" = "" ]; then show_usage "missing config file"; fi
FILE="$MDI_DIR/../config/$1"
if [ ! -e $FILE ]; then show_usage "unknown config file: $1"; fi

# open file in nano
nano $FILE
