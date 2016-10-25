FROM java:7u71-jre
ENV ANDROID_HOME=/android-sdk-linux
ENV PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
RUN curl -fL http://dl.google.com/android/android-sdk_r24.2-linux.tgz > /android.tgz


RUN tar xvf /android.tgz \
        && rm android.tgz

RUN apt-get update && apt-get -y install \
        lib32z1


ENV FILTER=android-19
CMD ( while [ 1 ]; do sleep 10; echo y; done ) | android update sdk -s --no-ui --filter $FILTER ; bash
