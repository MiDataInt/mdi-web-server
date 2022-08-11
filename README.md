# MDI AWS Public Server Support

The [Michigan Data Interface](https://midataint.github.io/) (MDI) 
is a framework for developing, installing and running 
Stage 1 HPC **pipelines** and Stage 2 interactive web applications 
(i.e., **apps**) in a standardized design interface.

This is the repository for the **MDI apps public server**. 
It will help you create a publicly addressable web server to run the MDI
web page with secure access, e.g., on an Amazon Web Services (AWS) instance.
It does this by providing scripts to build and run a series of 
Docker containers.

## General description

### Microservices run as Docker containers

The web server is run as a set of microservices from within
Docker containers. 

- <https://www.docker.com/>

One container runs the Traefik reverse proxy/load balancer
and routes requests to the other microservices.

- <https://docs.traefik.io/>

Other containers run the MDI, i.e., R Shiny, and other required 
support services. This repository has all files needed to easily 
build and manage all microservice images.

## Installation and use

### Host machine (AWS EC2 recommended)

The MDI web server will run on any machine that can run Docker and
that is addressable on the public internet. However, unless you have 
a specific reason to use your own server machine, we recommend using 
Amazon Web Services (AWS) to run a virtual server in the cloud on 
an Elastic Cloud Compute (EC2) instance.

The MDI maintains AWS Machine Images (AMIs) that make 
it easy and relatively painless to launch a public server instance.
Specifically, our AMIs already carry this mdi-web-server repository,
so you don't need to clone it yourself. Detailed instructions can be found here:

PENDING

Briefly, you will:
- use an MDI AMI to launch your AWS EC2 instance
- edit a few files to establish server configuration details (e.g., your web domain)
- make your site live!

### Public URL access

To use external authentication services, e.g., Google or Globus, 
your server must have a permanent internet domain name mapped to it 
via DNS. This allows SSL/TLS encryption security via Let's Encrypt.
A domain name is easily obtained using 
[AWS Route 53](https://console.aws.amazon.com/route53/v2/home).
