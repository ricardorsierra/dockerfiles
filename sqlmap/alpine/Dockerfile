FROM	alpine:edge
RUN	apk --no-cache add git python

ENV     SQLMAP_GITTAG=1.0.6
RUN	git clone -v  https://github.com/sqlmapproject/sqlmap.git \
		&& cd sqlmap \	
		&& git checkout tags/${SQLMAP_GITTAG}


WORKDIR	/sqlmap
VOLUME	/data
ENTRYPOINT ["./sqlmap.py"]
CMD ["-h"]
