# the email address of the contact person for SSL/TLS security
export WEBMASTER_EMAIL="example@umich.edu"

# the URL (i.e., domain name, without the https://) of your web server
# you can register your domain via Amazon Web Services (AWS) Route 53
export WEB_DOMAIN="example.org"

# the version of R used to run the MDI web server and all apps
export R_VERSION="4.1.0"

# the number of MDI, i.e., R Shiny, server processes to run
# 1 process per 2 CPUs is a good choice, but you can overload more aggressively
export N_SERVER_PROCESSES=2

# OPTIONAL: GitHub user and Personal Access Token to clone any private repositories in suites.yml
# !! NOTE: these values will be visible in the Docker image, so it must not be made public !!
# leave blank if you will only list public repositories in config/suites.yml
export GIT_USER=""
export GITHUB_PAT=""
