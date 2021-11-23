
## small footprint image
#FROM nginx:1.19-alpine
#
## set up nginx web server
#COPY nginx.conf /etc/nginx/conf.d/default.conf
#
## copy app static files
#ENV SERVICE_DIR /opt/nginx
#WORKDIR $SERVICE_DIR
#COPY index.html $SERVICE_DIR
#
## start the app server as a persistent process
#CMD ["nginx", "-g", "daemon off;"]



# small footprint image
FROM node:15.12.0-alpine3.10

# install express
ENV SERVICE_DIR /opt/node
WORKDIR $SERVICE_DIR
RUN npm install express

# copy app static files
COPY session-initialization.js $SERVICE_DIR

# start the app server as a persistent process
ARG WEB_DOMAIN
ENV WEB_DOMAIN=$WEB_DOMAIN
CMD ["node", "session-initialization.js"]

