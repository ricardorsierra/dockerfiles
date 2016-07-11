# Base docker image
FROM debian:jessie
MAINTAINER Jessica Frazelle <jess@docker.com>

# Install dependencies
RUN apt-get update && apt-get install -y \
	git \
	gconf2 \
	gconf-service \
	gvfs-bin \
	libasound2 \
	libgconf-2-4 \
	libgnome-keyring-dev \
	libgtk2.0-0 \
	libnotify4 \
	libnss3 \
	libxtst6 \
	xdg-utils \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENV ATOM_VERSION 1.8.0

# download the source
RUN buildDeps=' \
		ca-certificates \
		curl \
	' \
	&& set -x \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& curl -sSL https://github.com/atom/atom/releases/download/v${ATOM_VERSION}/atom-amd64.deb -o /tmp/atom-amd64.deb \
	&& dpkg -i /tmp/atom-amd64.deb \
	&& rm -rf /tmp/*.deb \
	&& apt-get purge -y --auto-remove $buildDeps

# ATOM PLUGINS LANGUAGES
RUN apm install linter linter-php linter-jshint atom-autocomplete-php php-integrator-refactoring atom-php-navigation php-debug

# ATOM MORE PLUGINS CVS and OTHERS
RUN apm install git-history minimap git-blame project-manager open-recent todo-show highlight-selected minimap-highlight-selected

# ATOM MORE PLUGINS HTML AND CODE BAUTIFY
RUN apm install autoclose-html emmet beautify file-icons

# ATOM PLUGINS -> PHP
RUN apm install git-blame project-manager emmet beautify

# ATOM THEMES
RUN apm install seti-ui

# Autorun atom
ENTRYPOINT [ "atom", "--foreground" ]
