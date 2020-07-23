FROM alpine:latest
LABEL maintainer="Ricardo Rebello Sierra <contato@ricardosierra.com.br>"


## https://github.com/soimort/you-get
# you-get(){
#   docker run -it --rm \
#     -u $(id -u):$(id -g) \
#     -v "$PWD":/downloads \
#     -w /downloads \
#     ondrejmo/you-get "$@"
# }

RUN apk update && apk add \
  ffmpeg \
  python3 \
  py-pip \
  && rm -rf /var/cache/apk/*
RUN pip3 install you-get

RUN mkdir -p /downloads
WORKDIR /downloads
VOLUME /downloads

ENTRYPOINT [ "you-get" ]
