FROM nginx:1-alpine
LABEL maintainer="IETF Tools Team <tools-discuss@ietf.org>"

# Setup nginx
COPY docker/configs/nginx-proxy.conf /etc/nginx/conf.d/
COPY docker/configs/nginx-502.html /var/www/html/502.html
