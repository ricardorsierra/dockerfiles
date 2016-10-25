FROM	alpine:edge

ENV	VERSION 2.6.0-r4

RUN	cat /proc/cpuinfo
RUN	apk add --no-cache qemu-system-x86_64=$VERSION \
		qemu-img=$VERSION

CMD ["qemu-system-x86_64"]
