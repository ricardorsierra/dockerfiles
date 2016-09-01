FROM ubuntu:xenial

RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*
    
RUN wget -O telegram.tar.xz http://telegram.org/dl/desktop/linux && \
    tar xf telegram.tar.xz -C ./telegram && \
    ./configure && \
    make && \
    make install && \
    rm telegram.tar.xz

CMD telegram
