FROM ubuntu:16.04

RUN apt-get update && apt-get -y install wget p7zip


ENV VERSION=3.00
RUN wget http://hashcat.net/files/hashcat-${VERSION}.7z

RUN 7zr x /hashcat-${VERSION}.7z \
    && mv hashcat-${VERSION} hashcat

ENV PATH=$PATH:/hashcat

ENTRYPOINT ["hashcat64.bin"]
