FROM ubuntu:15.04
MAINTAINER Paul Liljenberg liljenberg.paul@gmail.com
ENV MESOS_VERSION 0.25.0-0.2.70.ubuntu1504

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF \
	&& echo "deb http://repos.mesosphere.io/ubuntu vivid main" >> /etc/apt/sources.list.d/mesosphere.list \
	&& apt-get update \
	&& apt-cache madison mesos \
	&& apt-get install -y mesos=${MESOS_VERSION} \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

