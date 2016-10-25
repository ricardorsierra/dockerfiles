FROM ubuntu:14.04


RUN apt-get update && apt-get install -y \
  --no-install-recommends \
  python-cheetah \
  python-pip \
  build-essential \
  git-core \
  python-dev \
  python-openssl

RUN git clone https://github.com/SiCKRAGETV/SickRage.git sickrage

VOLUME /sickrage

EXPOSE 8081/tcp

ENTRYPOINT ["/sickrage/SickBeard.py"]
