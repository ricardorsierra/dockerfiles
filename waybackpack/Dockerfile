FROM alpine:latest
LABEL maintainer="Ricardo Rebello Sierra <contato@ricardosierra.com.br>"


## https://github.com/jsvine/waybackpack
# waybackpack(){
# 	docker run -it --rm \
#     -v "$PWD":/downloads \
#     -w /downloads  \
#     ondrejmo/waybackpack"$@"
# }

RUN apk update && apk add \
	python \
	py-pip \
	&& rm -rf /var/cache/apk/*
RUN pip install waybackpack

ENTRYPOINT [ "waybackpack" ]
