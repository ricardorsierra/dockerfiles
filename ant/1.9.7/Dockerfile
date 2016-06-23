FROM sierratecnologia/java:7

# Installs Ant
ENV ANT_VERSION 1.9.7
RUN cd && \
    wget -q http://mirror.nbtelecom.com.br/apache//ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz && \
    tar -xzf apache-ant-${ANT_VERSION}-bin.tar.gz && \
    mv apache-ant-${ANT_VERSION} /opt/ant && \
    rm apache-ant-${ANT_VERSION}-bin.tar.gz

ENV ANT_HOME /opt/ant
ENV PATH ${PATH}:/opt/ant/bin
