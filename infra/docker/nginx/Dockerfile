FROM node:14.2-alpine as node
FROM nginx:1.18-alpine
SHELL ["/bin/ash", "-oeux", "pipefail", "-c"]

ENV C=JP \
    ST=TOKYO \
    L=KITA-KU \
    O=creaside \
    OU=creaside \
    CN=localhost
ENV TZ Asia/Tokyo

RUN apk update && \
  apk add --update --no-cache --virtual=.build-dependencies g++ openssl

WORKDIR /etc/nginx/conf.d
RUN openssl genrsa 2048 > server.key;openssl req -new -key server.key -out server.csr -subj "/C=${C}/ST=${ST}/L=${L}/O=${O}/OU=${OU}/CN=${CN}";openssl x509 -days 3650 -req -signkey server.key < server.csr > server.crt
#COPY ./server.crt /etc/nginx/conf.d/server.crt
#COPY ./server.key /etc/nginx/conf.d/server.key


# node command
COPY --from=node /usr/local/bin /usr/local/bin
# npm command
COPY --from=node /usr/local/lib /usr/local/lib
# yarn command
COPY --from=node /opt /opt
# nginx config file
COPY ./infra/docker/nginx/*.conf /etc/nginx/conf.d/

WORKDIR /work/backend
