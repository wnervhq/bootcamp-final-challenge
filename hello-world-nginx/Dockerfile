FROM nginx:alpine

RUN apk update \
&& apk upgrade --available && sync \
&& apk --update add grep

COPY docker-deps/default.conf /etc/nginx/conf.d/default.conf

# Agregando Script personalizado para el control de WORKERS
COPY script/40-mod_nginx.sh  /docker-entrypoint.d/