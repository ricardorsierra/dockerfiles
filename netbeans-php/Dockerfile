FROM sierratecnologia/java:8
MAINTAINER Ricardo Sierra "sierra.csi@gmail.com"

ADD state.xml /tmp/state.xml

RUN wget http://download.netbeans.org/netbeans/8.1/final/bundles/netbeans-8.1-php-linux-x64.sh -O /tmp/netbeans.sh -q && \
    chmod +x /tmp/netbeans.sh && \
    echo 'Installing netbeans' && \
    /tmp/netbeans.sh --silent --state /tmp/state.xml && \
    rm -rf /tmp/*

ADD run /usr/local/bin/netbeans

RUN chmod +x /usr/local/bin/netbeans && \
    mkdir -p /home/developer && \
    echo "developer:x:1000:1000:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:1000:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown developer:developer -R /home/developer

USER developer
ENV HOME /home/developer
WORKDIR /home/developer
CMD /usr/local/bin/netbeans
