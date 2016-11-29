# Base docker image
FROM sierratecnologia/java:7
MAINTAINER Ricardo Rebello Sierra <contato@ricardosierra.com.br>

# Install dependencies
RUN apt-get update && apt-get install -y \
	libasound2 \
	libgconf-2-4 \
	libgnome-keyring-dev \
	libgtk2.0-0 \
	libnotify4 \
	libnss3 \
	libxtst6 \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENV MALTEGO_VERSION 3.4.0.5004

RUN wget -c https://www.paterva.com/malv34/community/MaltegoCE.v${MALTEGO_VERSION}.deb \
	&& dpkg -i MaltegoCE.v${MALTEGO_VERSION}.deb

# Autorun maltego
ENTRYPOINT [ "maltego", "--foreground" ]
