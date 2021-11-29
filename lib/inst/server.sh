#-------------------------------------------------------------
# REQUIRED
#-------------------------------------------------------------

# email address of the contact person for SSL/TLS security
export WEBMASTER_EMAIL="example@umich.edu"

# URL (i.e., domain name, without the https://) of your web server
# you can register your domain via Amazon Web Services (AWS) Route 53
export WEB_DOMAIN="example.org"

# version of R used to run the MDI web server and all apps
export R_VERSION="4.1.0"

# number of MDI, i.e., R Shiny, server processes to run
# 1 process per 2 CPUs is a good choice, but you can overload more aggressively
export N_SERVER_PROCESSES=2

#-------------------------------------------------------------
# OPTIONAL
#-------------------------------------------------------------

# GitHub Personal Access Token (PAT) to clone any private repositories
# leave blank if you will only use public repositories in config/suites.yml
export GITHUB_PAT=""

# !! your PAT is exposed in your Docker image, do not share the _image_ publicly !!
