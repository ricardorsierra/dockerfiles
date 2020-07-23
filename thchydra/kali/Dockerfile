FROM kalilinux/kali-linux-docker
LABEL maintainer="Ricardo Rebello Sierra <contato@ricardosierra.com.br>"


ENV	HYDRA_VERSION=8.2-2
RUN	apt-get update && apt-get -y install \
		hydra=$HYDRA_VERSION \
		&& rm -rf /var/cache/apt/archives/*

CMD ["-h"]
ENTRYPOINT ["/usr/bin/hydra"]
