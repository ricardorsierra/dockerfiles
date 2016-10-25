FROM debian:testing

RUN apt-get -y update && apt-get -y install \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

ENV PLEX_VERSION=1.1.4.2757-24ffd60
RUN curl -fL https://downloads.plex.tv/plex-media-server/${PLEX_VERSION}/plexmediaserver_${PLEX_VERSION}_amd64.deb > plex.deb \
    && dpkg -i plex.deb \
    && rm -v plex.deb

RUN mkdir -p /root/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/ \
    && curl -fL https://github.com/trakt/Plex-Trakt-Scrobbler/archive/master.zip > /trakt.zip \
    && unzip /trakt.zip \
    && mv -v /Plex-Trakt-Scrobbler-master/Trakttv.bundle /root/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/ \
    && rm -v /trakt.zip \
    && rm -rvf /Plex-Trakt-Scrobbler-master/


EXPOSE 32400
ENTRYPOINT ["/usr/sbin/start_pms"]
