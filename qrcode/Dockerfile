FROM python:3-slim
LABEL maintainer="Ricardo Rebello Sierra <contato@ricardosierra.com.br>"


## https://github.com/sylnsfar/qrcode
# myqr(){
# 	docker run -it --rm \
#     -u $(id -u):$(id -g) \
#     -v "$PWD":/qr \
#     -w /qr  \
#     ondrejmo/qrcode "$@"
# }

RUN pip3 install MyQR

VOLUME /qr
WORKDIR /qr

ENTRYPOINT [ "myqr" ]
