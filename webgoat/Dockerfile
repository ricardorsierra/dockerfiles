FROM	alpine:edge

RUN	apk --no-cache add \
		openjdk8-jre \
		curl

ENV	WEBGOAT_VERSION 7.0.1
RUN	curl -fL https://github.com/WebGoat/WebGoat/releases/download/${WEBGOAT_VERSION}/webgoat-container-${WEBGOAT_VERSION}-war-exec.jar -o /webgoat.jar

EXPOSE	8080


ENTRYPOINT	["java", "-jar", "/webgoat.jar"]
