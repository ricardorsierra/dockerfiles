FROM	alpine:edge
ENV     STARMADE_VERSION 20160320_064526

RUN	apk update && apk add \
	openjdk8-jre \
	unzip \
	curl

RUN	curl -fL http://files.star-made.org/build/starmade-build_${STARMADE_VERSION}.zip  > /starmade.zip
RUN	mkdir /STARMADE \
	&& unzip starmade.zip -d /STARMADE \
	&& rm -rvf starmade.zip


ENV	JAVA_OPTS="-Xms128m -Xmx1024m"
EXPOSE	4242

WORKDIR	/STARMADE
CMD	java $JAVA_OPTS -jar /STARMADE/StarMade.jar -server

