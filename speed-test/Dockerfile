FROM alpine:latest
LABEL maintainer="Ricardo Rebello Sierra <contato@ricardosierra.com.br>"


## https://github.com/sindresorhus/speed-test
# speed-test(){
#   docker run -it --rm \
#     --net host \
#     ondrejmo/speed-test "$@"
# }

RUN apk update && apk add nodejs \
  && rm -rf /var/cache/apk/*
RUN npm install -g speed-test \
  && rm -r /root/.npm

ENTRYPOINT [ "speed-test" ]
