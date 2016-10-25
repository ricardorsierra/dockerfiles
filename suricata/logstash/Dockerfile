FROM logstash:2
RUN apt-get update && apt-get -y install ruby

COPY setup.sh /
ENTRYPOINT ["/setup.sh"]
CMD ["logstash"]

