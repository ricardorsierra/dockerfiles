FROM debian:jessie
MAINTAINER Christian Koep <christian.koep@fom-net.de>

RUN apt-get update && apt-get -y install \
	ca-certificates \
	curl \
	tar \
	bzip2 \
	libglib2.0-0 \
	libx11-6 \
	libcairo2 \
	libpango-1.0-0 \
	libpangocairo-1.0-0 \
	libgtk2.0-0 \
	libcanberra-gtk-module:i386 \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -sSL "https://download.sublimetext.com/sublime_text_3_build_3114_x64.tar.bz2" -o /tmp/sublime.tar.bz2 \
	&& mkdir -p /usr/src/sublime_text \
	&& tar -xjf /tmp/sublime.tar.bz2 -C /usr/src/sublime_text --strip-components 1 \
	&& rm /tmp/sublime.tar.bz2*

CMD ["/usr/src/sublime_text/sublime_text", "-w"]
