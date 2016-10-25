FROM		debian:jessie
MAINTAINER	Paul Liljenberg <liljenberg.paul@gmail.com>

RUN	apt-get update && apt-get install -y \
		unzip \
		md5deep \
		wget \
		xmlstarlet \
		cabextract \
		genisoimage

ENV     WSUSOFFLINE_VERSION 1074
RUN	wget -O /wsusoffline.zip http://download.wsusoffline.net/wsusoffline"${WSUSOFFLINE_VERSION}".zip
RUN	unzip /wsusoffline.zip \
		&& rm /wsusoffline.zip \
		&& chmod +x /wsusoffline/sh/DownloadUpdates.sh

WORKDIR		/wsusoffline/sh
ENV		EXCLUDE_SP=0

CMD ./DownloadUpdates.sh all-x64 enu /makeiso /dotnet /msse /wle
