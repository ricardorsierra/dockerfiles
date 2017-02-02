# Base docker image
FROM debian:latest
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
	kicad
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

# Autorun kicad
WORKDIR /var/www
CMD gitk
