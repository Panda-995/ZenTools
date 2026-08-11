# syntax=docker/dockerfile:1

FROM nginx:alpine

COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY . /usr/share/nginx/html

# The Nginx configuration is build-time input, not a public site asset.
RUN rm -rf /usr/share/nginx/html/docker

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q -O /dev/null http://127.0.0.1/healthz || exit 1
