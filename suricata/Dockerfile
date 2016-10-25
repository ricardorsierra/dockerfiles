FROM ubuntu:14.04

ENV SURICATA_VERSION 2.0.8-0ubuntu8
RUN echo 'deb http://ppa.launchpad.net/oisf/suricata-stable/ubuntu trusty main' >> /etc/apt/sources.list.d/suricata.list \
    && echo 'deb-src http://ppa.launchpad.net/oisf/suricata-stable/ubuntu trusty main' >> /etc/apt/sources.list.d/suricata.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 66EB736F \
    && apt-get update \
    && apt-cache madison suricata \
    && apt-get -y install \
    suricata=${SURICATA_VERSION} \
    ethtool

VOLUME /var/log/suricata

RUN mkdir -p /etc/suricata/rules
WORKDIR /etc/suricata

COPY suricata.yaml /etc/suricata/
COPY setup.sh /
ENTRYPOINT ["/setup.sh"]
