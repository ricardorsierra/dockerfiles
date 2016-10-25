# Usage:
# docker run -it --cap-add NET_ADMIN --net host pandrew/aircrack-ng

FROM		alpine:edge
MAINTAINER      Paul Liljenberg "liljenberg.paul@gmail.com"
ENV		VERSION=1.2_rc4-r1
RUN		apk add --no-cache aircrack-ng=$VERSION
CMD		aircrack-ng
