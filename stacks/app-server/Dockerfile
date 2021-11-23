
# build a Docker image with magc-portal and magc-portal-apps
# installed for use in server mode

# use a specific R version, same as the tag on the resulting image
ARG VERSION
FROM r-base:$VERSION

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

# hard set portalDir in image
ENV PORTAL_DIR=/srv/magc-portal
WORKDIR $PORTAL_DIR

# install 'remotes' to support R package installation from GitHub
RUN Rscript -e "install.packages('remotes')"

# install the 'magc-portal' application manager
# TODO: remove GITHUB_PAT
ARG GITHUB_PAT
RUN Rscript -e "remotes::install_github('UMAGC/magc-portal', auth_token='"$GITHUB_PAT"')"

# use the installer to install the MAGC Portal, i.e. the 'magc-portal-apps|pipelines' repositories
# checkout branch 'develop' to start with (magc.portal::run switches to the correct production version)
# TODO: remove GITHUB_PAT
RUN Rscript -e "magc.portal::install(portalDir=getwd(), checkout='develop', token='"$GITHUB_PAT"')"

# provide a hook to allow magc.portal::install to re-pull the repos without re-installing most R packages
# re-building with a new PACKAGE_BUILD_NUMBER updates cloned code repositories at the _image_ level
ENV PACKAGE_BUILD_NUMBER=1
# TODO: remove GITHUB_PAT
RUN Rscript -e "magc.portal::install(portalDir=getwd(), checkout='develop', token='"$GITHUB_PAT"')"

# provide a second hook similar to above, purpose here is for more frequent code changes (not packages)
ENV CODE_BUILD_NUMBER=1
# TODO: remove GITHUB_PAT
RUN Rscript -e "magc.portal::install(portalDir=getwd(), checkout='develop', token='"$GITHUB_PAT"')"

# remove a hacky DT css file with !important that blocks us from controlling css ourselves
# needed since shinydashboard page functions don't allow us to force our css to load last
RUN echo "" > `ls $PORTAL_DIR/magc-portal-library/*/DT/htmlwidgets/lib/datatables/css/jquery.dataTables.extra.css`

# enable rolling updates and hotfixes
# running pull-code-repositories.sh updates cloned code repositories at the _container_ level
COPY ./pull-code-repositories.sh  $PORTAL_DIR/pull-code-repositories.sh
COPY ./purge-developer-tools.sh   $PORTAL_DIR/purge-developer-tools.sh

# remove dangerous code from magc-portal-apps not applicable to server mode
RUN bash purge-developer-tools.sh

# add the server startup script
COPY ./start-app-server.R  $PORTAL_DIR/start-app-server.R

# if this image is run as a container manually, just provide a command line
# start-app-server.R is called via the 'command' in app-server-stack.yml
CMD ["/bin/bash"]

