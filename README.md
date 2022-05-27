# Michigan Data Interface

The [Michigan Data Interface](https://midataint.github.io/) (MDI) 
is a framework for developing, installing and running 
HPC data analysis pipelines and interactive visualization 
applications within a standardized design interface.

The MDI is separated into 
[two stages of code execution](https://midataint.github.io/docs/analysis-flow/) 
called Stage 1 HPC **pipelines** and Stage 2 web applications (i.e., **apps**).
Collectively, pipelines and apps are known as **tools**.

## Repository contents

This is the repository for the **MDI apps public server**. 
It will help you create a publicly addressable web server to run the MDI
web page with secure access by providing scripts to build and run a series of 
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
support services. This repository has all files needed to 
build and manage all microservice images.

## Installation and use

### Host machine (AWS EC2 recommended)

The MDI web server will run on any machine that can run Docker and
that is addressable on the public internet. We recommend using 
[Amazon Web Services](https://aws.amazon.com/) (AWS) 
to run a virtual server in the cloud on an 
[Elastic Compute Cloud](https://aws.amazon.com/pm/ec2) (EC2) instance.

The MDI maintains public AWS Machine Images (AMIs) that make 
it easy to launch a public server instance.
The AMIs already carry this mdi-web-server repository,
so you don't need to clone it yourself. Detailed instructions can be found here:

- https://github.com/MiDataInt/mdi-aws-ami

Briefly, you will:
- use an MDI AMI to launch your AWS EC2 instance
- edit a few files to establish server configuration details (e.g., your web domain)
- make your site live

### Public URL access

To use external authentication services, e.g., Google or Globus, 
your server must have a permanent internet domain name mapped to it 
via DNS. This allows SSL/TLS encryption security via 
[Let's Encrypt](https://letsencrypt.org/).
A domain name is easily obtained using 
[AWS Route 53](https://console.aws.amazon.com/route53/v2/home).
