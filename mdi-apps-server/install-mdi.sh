# this script runs in an apps-server container to install the MDI 
# into the persistent docker volume known to all such containers

# copy in the up-to-date config files
mkdir -p $MDI_DIR/config
cp -r /srv/config/* $MDI_DIR/config

# set the number of cores for parallel R package compilation
export N_CPU=`nproc`

# set environment variable to honor system library in server images
export MDI_SYSTEM_R_LIBRARY=/usr/local/lib/R/site-library

# update the installation manager, if new since Docker image was created
Rscript -e "remotes::install_github('MiDataInt/mdi-manager', Ncpus = $N_CPU)"

# use the manager to install the MDI repositories and R packages
Rscript -e "mdi::install(Sys.getenv('MDI_DIR'), confirm = FALSE)"

# remove R package tarballs to control image/container size
rm -f /tmp/Rtmp*/downloaded_packages/*.tar.gz

# remove a hacky DT css file with !important that blocks us from controlling css ourselves
# needed since shinydashboard page functions don't allow us to force our css to load last
echo "" > $MDI_DIR/library/*/DT/htmlwidgets/lib/datatables/css/jquery.dataTables.extra.css
