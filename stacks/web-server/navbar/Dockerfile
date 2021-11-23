
# small footprint image
FROM nginx:1.19-alpine

# set up nginx web server
COPY nginx.conf /etc/nginx/conf.d/default.conf

# copy app static files (html, css, etc.)
ENV SERVICE_DIR /opt/nginx
WORKDIR $SERVICE_DIR
COPY index.html $SERVICE_DIR
COPY www $SERVICE_DIR/www
COPY html $SERVICE_DIR/html

# start the app server as a persistent process
CMD ["nginx", "-g", "daemon off;"]

