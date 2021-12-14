# Michigan Data Interface

The [Michigan Data Interface](https://midataint.github.io/) (MDI) is a framework for developing,
installing and running a variety of HPC data analysis pipelines
and interactive R Shiny data visualization applications
within a standardized design and implementation interface.

## Repository contents

Data analysis in the MDI is logically separated into 
[two stages of code execution](https://midataint.github.io/docs/analysis-flow/) 
called Stage 1 HPC **pipelines**
and Stage 2 web applications (i.e., **apps**).

This is the repository for the **MDI apps public server**. 
It will help you create a publicly addressable web server to run the MDI
web page with secure access, e.g., on an Amazon Web Services instance.
It does this by providing scripts to build and run a series of 
Docker containers.

You do not need this repository to run the MDI on your local computer
or on a remote server via SSH, only if you wish to have a
web page running the MDI at a permanent URL such as 'johndoelab.org'. 

### Related repositories

This repository does not contain web apps themselves or even the MDI
apps framework. Please explore these repositories for those components:

- <https://github.com/MiDataInt/mdi-manager>
- <https://github.com/MiDataInt/mdi-apps-framework>
- <https://github.com/MiDataInt/mdi-apps-suite-template>

For more information on the code we use to create the Amazon
Machine Images recommended below, please see:

- <https://github.com/MiDataInt/mdi-aws-mdi>

## General Description

### Microservices run as Docker containers

The web server is run as a set of microservices from within
Docker containers. 

https://www.docker.com/

One container runs the Traefik reverse proxy/load balancer
and routes requests to the other microservices.

https://docs.traefik.io/

Other containers run the MDI, i.e., R Shiny, and other required 
support services. This repository has all files needed to easily 
build and manage all microservice images.

## Installation and Use

### Host machine (AWS EC2 recommended)

The MDI web server will run on any machine that can run Docker and
that is addressable on the public internet. However, unless you have 
a specific reason to use your own server machine, we recommend using 
Amazon Web Services (AWS) to run a virtual server in the cloud on 
an EC2 compute instance.

The MDI maintains AWS Machine Images (AMIs) that make 
it easy and relatively painless to launch a public server instance.
Specifically, our AMIs already carry this mdi-web-server repository,
so you don't need to clone it yourself. Detailed instructions can be found here:

PENDING

Briefly, you will:
- use an MDI AMI to launch your AWS EC2 instance
- edit a few files to establish server configuration details (e.g., URL)
- make your site live!

### Public URL access

To use external authentication services, e.g., Google or Globus, 
your server must have a permanent internet domain name mapped to it 
via DNS. This allows SSL/TLS encryption security via Let's Encrypt.
A domain name is easily obtained using 
[AWS Route 53](https://console.aws.amazon.com/route53/v2/home).
