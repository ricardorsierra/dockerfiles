FROM alpine:edge

RUN apk --no-cache add \
    openjdk8-jre \
    curl

ENV MINECRAFT_VERSION 1.10.2
RUN curl -fL https://s3.amazonaws.com/Minecraft.Download/versions/$MINECRAFT_VERSION/minecraft_server.$MINECRAFT_VERSION.jar  > /minecraft.jar
RUN chmod +x /minecraft.jar

RUN mkdir /minecraft
WORKDIR /minecraft

RUN echo eula=true > eula.txt

EXPOSE 25565

ENTRYPOINT ["java"]
CMD ["-Xmx1536M", "-Xms768M", "-jar", "/minecraft.jar", "nogui"]
