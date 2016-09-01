FROM ubuntu:xenial

RUN add-apt-repository ppa:atareao/telegram && \
    apt-get update && \
    apt-get install telegram && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

CMD telegram
