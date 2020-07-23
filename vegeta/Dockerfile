FROM golang:alpine
LABEL maintainer="Ricardo Rebello Sierra <contato@ricardosierra.com.br>"


## https://github.com/tsenart/vegeta
# vegeta() {
#   docker run -it --rm \
#     ondrejmo/vegeta "$@"
# }

RUN apk update && apk add git \
  && rm -rf /var/cache/apk/*
RUN go get -u github.com/tsenart/vegeta

ENTRYPOINT [ "vegeta" ]
