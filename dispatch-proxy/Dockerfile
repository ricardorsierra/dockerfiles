FROM alpine:latest
MAINTAINER Ondřej Molík <ondrejmo@outlook.com>

## https://github.com/Morhaus/dispatch-proxy
# dispatch(){
#   docker run -it --rm \
#     --net host \
#     ondrejmo/dispatch-proxy "$@"
# }

RUN apk update && apk add nodejs \
  && rm -rf /var/cache/apk/*
RUN npm install -g dispatch-proxy \
  && rm -r /root/.npm

ENTRYPOINT [ "dispatch" ]
