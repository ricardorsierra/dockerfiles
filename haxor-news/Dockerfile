FROM alpine:latest
LABEL maintainer="Ricardo Rebello Sierra <contato@ricardosierra.com.br>"


## https://github.com/donnemartin/haxor-news
# hn(){
#   docker run -it --rm \
#     ondrejmo/haxor-news "$@"
# }

RUN apk update && apk add \
  python \
  py-pip \
  && rm -rf /var/cache/apk/*
RUN pip install haxor-news

ENTRYPOINT [ "hn" ]
