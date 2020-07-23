FROM node:latest
LABEL maintainer="Ricardo Rebello Sierra <contato@ricardosierra.com.br>"


## https://github.com/hacksalot/HackMyResume
# hackmyresume() {
#   docker run -it --rm \
#     ondrejmo/hackmyresume "$@"
# }

RUN npm install -g hackmyresume

## Install themes
# npm install jsonresume-theme-[theme-name]

WORKDIR /data
VOLUME /data

ENTRYPOINT [ "hackmyresume" ]
