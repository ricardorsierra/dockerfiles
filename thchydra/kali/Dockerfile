FROM kalilinux/kali-linux-docker
MAINTAINER Paul Liljenberg "liljenberg.paul@gmail.com"

ENV	HYDRA_VERSION=8.2-2
RUN	apt-get update && apt-get -y install \
		hydra=$HYDRA_VERSION \
		&& rm -rf /var/cache/apt/archives/*

CMD ["-h"]
ENTRYPOINT ["/usr/bin/hydra"]
