FROM debian:jessie
LABEL maintainer="Ricardo Rebello Sierra <contato@ricardosierra.com.br>"


RUN apt-get update && apt-get install -y libav-tools

ADD flac2mp3.sh /

VOLUME /data

ENTRYPOINT ["/flac2mp3.sh"]
