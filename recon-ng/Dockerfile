FROM python:2
LABEL maintainer="Ricardo Rebello Sierra <contato@ricardosierra.com.br>"


RUN git clone https://bitbucket.org/LaNMaSteR53/recon-ng.git \
    && cd recon-ng \
    && pip install -r REQUIREMENTS

WORKDIR /recon-ng

ENTRYPOINT ["./recon-ng"]
