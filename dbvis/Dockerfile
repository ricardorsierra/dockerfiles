FROM sierratecnologia/java:8

RUN wget https://www.dbvis.com/product_download/dbvis-9.5/media/dbvis_linux_9_5.deb -O dbvis.deb; \
    dpkg -i dbvis.deb

CMD dbvis
