FROM ubuntu:xenial

RUN apt-get update -y && \
    apt-get install -y libcanberra-gtk-module:i386 dia && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

CMD dia
