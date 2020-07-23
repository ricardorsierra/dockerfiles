FROM redis:3.2.9-alpine
LABEL maintainer="Ricardo Rebello Sierra <contato@ricardosierra.com.br>"


RUN apk add --no-cache \
        curl \
        bash

ADD docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 26379

ENTRYPOINT ["/docker-entrypoint.sh"]
