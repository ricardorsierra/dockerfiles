## PhoneGap Dockerfile

This repository contains **Dockerfile** of [PostgreSQL](http://www.postgresql.org/) combined with PL/Perl for [Docker](https://www.docker.com/)'s [build](https://registry.hub.docker.com/u/sierratecnologia/phonegap/) published to the public [Docker Hub](https://hub.docker.com/).

### Installation

1. Install [Docker](https://www.docker.com/).

2. Pull the image
  * `docker pull sierratecnologia/postgresql-with-plperl:8.4`

### Usage

See the verified PostgreSQL image [documentation](https://registry.hub.docker.com/_/postgres/)

#### Add PL/Perl to a database

    docker exec <container-id> createlang -U <db-user> plperl <db-name>
