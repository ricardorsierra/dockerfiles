# Usage:
# docker run -it --cap-add NET_ADMIN --net host pandrew/aircrack-ng

FROM		alpine:edge
LABEL maintainer="Ricardo Rebello Sierra <contato@ricardosierra.com.br>"

ENV		VERSION=1.2_rc4-r1
RUN		apk add --no-cache aircrack-ng=$VERSION
CMD		aircrack-ng
