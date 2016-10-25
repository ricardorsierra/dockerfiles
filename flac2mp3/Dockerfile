FROM debian:jessie
MAINTAINER Paul Liljenberg liljenberg.paul@gmail.com

RUN apt-get update && apt-get install -y libav-tools

ADD flac2mp3.sh /

VOLUME /data

ENTRYPOINT ["/flac2mp3.sh"]
