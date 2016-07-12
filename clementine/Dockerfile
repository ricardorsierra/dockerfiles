FROM ubuntu:xenial

RUN apt-get update -y && \
    apt-get install -y clementine && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

WORKDIR /root/Music
CMD clementine
