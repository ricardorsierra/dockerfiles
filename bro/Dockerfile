FROM debian:8


ENV BRO_VERSION 2.4.1-0
RUN apt-get update && apt-get -y install \
    curl 

# Install key to verify package
RUN curl -fL http://download.opensuse.org/repositories/network:bro/Debian_8.0/Release.key \
    | apt-key add -

# Install repository
RUN echo 'deb http://download.opensuse.org/repositories/network:/bro/Debian_8.0/ /' >> /etc/apt/sources.list.d/bro.list

# Update cache and install bro
RUN	apt-get update && \
	apt-get -y install bro="${BRO_VERSION}"

ENV PATH=/opt/bro/bin:$PATH

CMD "--help"
ENTRYPOINT ["bro"]
