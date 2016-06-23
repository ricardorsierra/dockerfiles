FROM buildpack-deps:jessie-curl

ENV FDB_VERSION 3.0.6

RUN curl -SLO "https://foundationdb.com/downloads/I_accept_the_FoundationDB_Community_License_Agreement/key-value-store/${FDB_VERSION}/foundationdb-clients_${FDB_VERSION}-1_amd64.deb" \
 && dpkg -i foundationdb-clients_${FDB_VERSION}-1_amd64.deb \
 && rm foundationdb-clients_${FDB_VERSION}-1_amd64.deb

CMD [ "fdbcli" ]
