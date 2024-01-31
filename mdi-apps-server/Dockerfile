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
    libmagick++-dev \
    libx11-dev \
    libgit2-dev \
    libssh2-1-dev \
    libglpk-dev \
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

# install the MDI installation manager
# increment MANAGER_INSTALL_HOOK to force mdi-manager to update on the next call to "server build"
ENV MANAGER_INSTALL_HOOK=1
RUN Rscript -e "remotes::install_github('MiDataInt/mdi-manager', Ncpus = "`nproc`")"

# remove R package tarballs to control image/container size
RUN rm -f /tmp/Rtmp*/downloaded_packages/*.tar.gz

# set GitHub credentials
ARG GITHUB_PAT
ENV GITHUB_PAT=$GITHUB_PAT
ARG GIT_USER
ENV GIT_USER=$GIT_USER
ARG USER_NAME
ENV USER_NAME=$USER_NAME
ARG USER_EMAIL
ENV USER_EMAIL=$USER_EMAIL

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
COPY ./update-config.sh $TOOLS_DIR/update-config.sh

# add the server startup script
COPY ./start-app-server.R $TOOLS_DIR/start-app-server.R

# set up .bashrc when working interactively in bash in container
RUN echo 'alias ll="ls -alF"' >> ~/.bashrc 

# if this image is run as a container manually, just provide a command line
# start-app-server.R is called via 'command' in docker-compose.yml
CMD ["/bin/bash"]
