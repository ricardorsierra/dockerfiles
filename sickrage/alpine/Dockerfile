FROM alpine:edge
ENV SICKRAGE_VERSION=8.0.3
RUN apk --no-cache add python py-pip ca-certificates
RUN pip install sickrage==${SICKRAGE_VERSION}

CMD ["sickrage"]
