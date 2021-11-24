# use a specific R version, same as the tag on the resulting image
ARG R_VERSION
FROM r-base:$R_VERSION

# prepare the system to install R packages
# include some useful tools for developer use
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libmariadb-dev \
    zlib1g-dev \
    libxml2 \
    libxml2-dev \
    libssl-dev \
    libpng-dev \
    libjpeg-dev \
    pkg-config \
    build-essential \
    nano \
    curl \
    git

# hard set installation directory in image
ENV MDI_DIR=/srv/mdi
WORKDIR $MDI_DIR

# install 'remotes' to support R package installation from GitHub
RUN Rscript -e "install.packages('remotes')"

# set GitHub credentials; usually left blank unless private repos are listed in suites.yml
ARG GITHUB_USER
ARG GITHUB_PAT
ENV GITHUB_USER=$GITHUB_USER
ENV GITHUB_PAT=$GITHUB_PAT

# install the installation manager
RUN Rscript -e "remotes::install_github('MiDataInt/mdi-manager')"

# use the manager to install the framework repositories and R packages
RUN Rscript -e "mdi::install(getwd(), confirm = FALSE, addToPATH = TRUE)"

# copy in suites.yml to update server-specific apps suites without reinstalling framework packages
# re-building will thus update cloned code repositories and packages at the _image_ level
COPY ./config/suites.yml  $MDI_DIR/config/suites.yml
RUN Rscript -e "mdi::install(getwd(), confirm = FALSE, addToPATH = FALSE)"

# provide a hook similar to help developers update code changes without reinstalling upstream packages
ENV CODE_BUILD_NUMBER=1
RUN Rscript -e "mdi::install(getwd(), confirm = FALSE, addToPATH = FALSE)"

# remove a hacky DT css file with !important that blocks us from controlling css ourselves
# needed since shinydashboard page functions don't allow us to force our css to load last
RUN echo "" > `ls $MDI_DIR/library/*/DT/htmlwidgets/lib/datatables/css/jquery.dataTables.extra.css`

# # enable rolling updates and hotfixes
# # running pull-code-repositories.sh updates cloned code repositories at the _container_ level
# COPY ./pull-code-repositories.sh  $MDI_DIR/pull-code-repositories.sh
# COPY ./purge-developer-tools.sh   $MDI_DIR/purge-developer-tools.sh

# # remove dangerous code not applicable to server mode
# RUN bash purge-developer-tools.sh

# add the server startup script
COPY ./mdi-web-server/mdi-apps-server/start-app-server.R  $MDI_DIR/start-app-server.R

# if this image is run as a container manually, just provide a command line
# start-app-server.R is called via the 'command' in app-server-stack.yml
CMD ["/bin/bash"]
