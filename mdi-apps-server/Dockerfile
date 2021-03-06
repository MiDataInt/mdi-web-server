# use a specific R version
ARG R_VERSION
FROM r-base:$R_VERSION

# suppress a docker compose build warning that build-args R_VERSION was not consumed
ARG R_VERSION

# prepare the system to install R packages
# include some useful tools for developer use
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libmariadb-dev \
    zlib1g-dev \
    libxml2 \
    libxml2-dev \
    libpng-dev \
    libjpeg-dev \
    libtiff-dev \
    libx11-dev \
    libgit2-dev \
    libssh2-1-dev \
    pkg-config \
    build-essential \
    git \
    wget \
    zip \
    time \
    nano \
    tree \
    curl

# install 'remotes' to support R package installation from GitHub
RUN Rscript -e "install.packages('remotes', Ncpus = "`nproc`")"

# install the installation manager
ENV MANAGER_INSTALL_HOOK=1
RUN Rscript -e "remotes::install_github('MiDataInt/mdi-manager', Ncpus = "`nproc`")"

# remove R package tarballs to control image/container size
RUN rm -f /tmp/Rtmp*/downloaded_packages/*.tar.gz

# set GitHub credentials
ARG GITHUB_PAT
ENV GITHUB_PAT=$GITHUB_PAT

# hard set installation directory in image
ARG MDI_DIR
ENV MDI_DIR=$MDI_DIR

# install server management tools in /srv/tools
# the image launches in this directory
ENV TOOLS_DIR=/srv/tools
WORKDIR $TOOLS_DIR

# add scripts to install, update and modify the MDI
COPY ./install-mdi.sh $TOOLS_DIR/install-mdi.sh
COPY ./get-resource.sh $TOOLS_DIR/get-resource.sh

# add the server startup script
COPY ./start-app-server.R $TOOLS_DIR/start-app-server.R

# if this image is run as a container manually, just provide a command line
# start-app-server.R is called via 'command' in docker-compose.yml
CMD ["/bin/bash"]
