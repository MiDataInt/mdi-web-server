# use a specific R version
ARG R_VERSION
FROM r-base:$R_VERSION

# suppress a docker-compose build warning that build-args R_VERSION was not consumed (see above)
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
    libssl-dev \
    libpng-dev \
    libjpeg-dev \
    pkg-config \
    build-essential \
    nano \
    curl \
    tree \
    git

# install 'remotes' to support R package installation from GitHub
RUN Rscript -e "install.packages('remotes')"

# set GitHub credentials
# TODO: delete once mdi-manager is public
ARG GITHUB_PAT
ENV GITHUB_PAT=$GITHUB_PAT

# install the installation manager
RUN Rscript -e "remotes::install_github('MiDataInt/mdi-manager')"

# hard set installation directory in image
ARG MDI_DIR
ENV MDI_DIR=$MDI_DIR

# install server management tools in /srv/tools
ENV TOOLS_DIR=/srv/tools
WORKDIR $TOOLS_DIR

# add the script to install, update and modify the MDI
COPY ./install-mdi.sh $TOOLS_DIR/install-mdi.sh
COPY ./get-resource.sh $TOOLS_DIR/get-resource.sh

# add the server startup script
COPY ./start-app-server.R $TOOLS_DIR/start-app-server.R

# if this image is run as a container manually, just provide a command line
# start-app-server.R is called via the 'command' in app-server-stack.yml
CMD ["/bin/bash"]
