
# MAGC Portal Server

This is the repository for the web server of the analysis portal
of the Michigan (M) Advanced Genomics Core (AGC).

This repository contains all code required to run the public web
server. It does not contain the code for the web page itself
(see repository 'magc-portal-apps'). It also does not contain three
required server-specific configuration files (please inquire if
you need to replicate our public server).

Most users will NOT want to use 'magc-portal-server', but instead
will run the MAGC Portal on their local computer using the
'magc-portal-apps' repository. 

## General Description

### Microservices run as containers in a Docker Swarm

The Portal is run as a set of microservices from within
Docker containers. Those containers are managed as a Docker Swarm.

https://docs.docker.com/engine/swarm/

One container running the Traefik reverse proxy/load balancer
routes requests to the other microservices.

https://docs.traefik.io/

This repository has all files to build all microservice images.
It also has helper scripts to deploy the Swarm service stacks.

### Data analysis applications mostly utilize R Shiny

One microservice called 'app-server' runs a single R Shiny
application that provides a common framework and interface
for a series of specific data analysis apps. All apps
are/can be served by any app-server task intance.

Please note that the configuration is flexible and can
adapt to any type of web analysis scripting platform, by simply
creating a new framework or other distinct images and services.

## Installation and Use

The Portal will run on any machine that can run Docker, including
desktop or laptop computers. No other software installations
are required; it is all maintained in the Docker images/containers.
Thus, clone this repository, configure, build and deploy.

To run in multi-user, i.e. 'server' mode, the server must have a
permanent internet domain name mapped to it via DNS. This allows
SSL/TLS encryption security via Let's Encrypt.

