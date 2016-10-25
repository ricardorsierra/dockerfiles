FROM debian:8
MAINTAINER Paul Liljenberg "liljenberg.paul@gmail.com"


RUN apt-get update && apt-get -y install \
    --no-install-recommends \
    ca-certificates \
    gcc \
    git-core \
    make \
    libssl-dev \
    libssh-dev \
    libidn11-dev \
    libpcre3-dev \
    libgtk2.0-dev \
    libmysqlclient-dev \
    libpq-dev libsvn-dev \
    firebird2.1-dev \
    libncap-dev

RUN git clone https://github.com/vanhauser-thc/thc-hydra.git \
        && cd thc-hydra \
        && ./configure \
        && make \
        && make install

# Cleanup
RUN rm -rvf /thc-hydra

VOLUME /data
WORKDIR /data

CMD ["-h"]
ENTRYPOINT ["/usr/local/bin/hydra"]
