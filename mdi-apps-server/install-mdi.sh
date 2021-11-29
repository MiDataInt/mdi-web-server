# this script runs in an apps-server container to install the MDI 
# into the persistent docker volume known to all such containers

# copy in the up-to-date config files
mkdir -p $MDI_DIR/config
cp -r /srv/config/* $MDI_DIR/config

# update the installation manager, if new since Docker image was created
Rscript -e "remotes::install_github('MiDataInt/mdi-manager')"

# use the manager to install the framework repositories and R packages
Rscript -e "mdi::install(Sys.getenv('MDI_DIR'), confirm = FALSE, addToPATH = TRUE)"

# remove a hacky DT css file with !important that blocks us from controlling css ourselves
# needed since shinydashboard page functions don't allow us to force our css to load last
echo "" > $MDI_DIR/library/*/DT/htmlwidgets/lib/datatables/css/jquery.dataTables.extra.css
