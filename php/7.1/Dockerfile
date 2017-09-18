# Based on the Dockerfile from the docker-library.
# - version updated to 5.5.21
# - sqlite support removed
# - pgsql support added.
# - mssql support added.
# - redis support added.

FROM debian:jessie

# Custom Dockerfile
MAINTAINER Ricardo Sierra <ricardo@ricardosierra.com.br>
MAINTAINER Claydionei <claydionei@fidelize.com.br>
MAINTAINER Charles Cunico <charles.cunico@fidelize.com.br>

ENV PHP_INI_DIR /usr/local/etc/php
RUN mkdir -p $PHP_INI_DIR/conf.d

ENV PHP_EXTRA_BUILD_DEPS php7.0-sybase php7.0-soap
ENV PHP_EXTRA_CONFIGURE_ARGS --enable-mbstring --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data

ENV GPG_KEYS A917B1ECDA84AEC2B568FED6F50ABC807BD5DCD0 528995BFEDFBA7191D46839EF9BA0ADA31CBD89E
RUN set -xe \
    && for key in $GPG_KEYS; do \
        gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
    done

ENV PHP_VERSION 7.1.5
ENV PHP_FILENAME php-7.1.5.tar.xz
ENV PHP_SHA256 d149a3c396c45611f5dc6bf14be190f464897145a76a8e5851cf18ff7094f6ac

ENV PHP_EXTENSIONS_DIR /usr/local/lib/php/extensions/no-debug-non-zts-20160303

RUN echo "deb http://ftp.debian.org/debian/ jessie-updates main contrib non-free" >> /etc/apt/sources.list

RUN buildDeps=" \
#        $PHP_EXTRA_BUILD_DEPS \
        build-essential \
        libcurl4-openssl-dev \
        libreadline6-dev \
        librecode-dev \
        libssl-dev \
        libxml2 \
        libxml2-dev \
        libpq-dev \
        libicu-dev \
        libsasl2-dev \
        libmcrypt4 \
        libmcrypt-dev \
        libpng12-dev \
        libjpeg62-turbo-dev \
        libfreetype6-dev \
        libbz2-dev \
        librecode0 \
        libsqlite3-0 \
        libgearman-dev \
        libsodium-dev \
        libc-dev \
        xz-utils \
        wget \
        git \
        ca-certificates \
        curl \
        autoconf \
        file \
        g++ \
        gcc \
        make \
        pkg-config \
        re2c \
        unzip \
        zip \
        vim \
        nano \
        telnet \
        netstat-nat \
        tar \
    " \
    && set -x \
    && apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
    && curl -fSL "http://php.net/get/$PHP_FILENAME/from/this/mirror" -o "$PHP_FILENAME" \
    && echo "$PHP_SHA256 *$PHP_FILENAME" | sha256sum -c - \
    && curl -fSL "http://php.net/get/$PHP_FILENAME.asc/from/this/mirror" -o "$PHP_FILENAME.asc" \
    && gpg --verify "$PHP_FILENAME.asc" \
    && mkdir -p /usr/src/php \
    && tar -xf "$PHP_FILENAME" -C /usr/src/php --strip-components=1 \
    && rm "$PHP_FILENAME"* \
    && cd /usr/src/php \
    && ./configure \
        --with-config-file-path="$PHP_INI_DIR" \
        --with-config-file-scan-dir="$PHP_INI_DIR/conf.d" \
        $PHP_EXTRA_CONFIGURE_ARGS \
        --disable-cgi \
        --with-curl \
        --with-openssl \
        --with-readline \
        --with-recode \
        --with-zlib \
                --enable-pcntl \
    && make -j"$(nproc)" \
    && make install \
    && { find /usr/local/bin /usr/local/sbin -type f -executable -exec strip --strip-all '{}' + || true; } \
    #&& apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $buildDeps \
    && make clean

# Docker PHP EXT BIN
COPY build/docker-php-ext-* /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-php-ext-*

RUN pecl channel-update pecl.php.net

# Postgres
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/include/postgresql/ && \
    docker-php-ext-install pgsql pdo_pgsql

# Install Gearman
RUN cd /root/ && \
    wget http://github.com/wcgallego/pecl-gearman/archive/master.zip && \
    unzip master.zip && \
    cd pecl-gearman-master && \
    phpize  && \
    ./configure  && \
    make install  && \
    cp /root/pecl-gearman-master/modules/gearman.so $PHP_EXTENSIONS_DIR/gearman.so && \
    echo "extension=$PHP_EXTENSIONS_DIR/gearman.so" > /usr/local/etc/php/conf.d/gearman.ini

# Install dbase (beta)
RUN pecl install dbase-7.0.0beta1 && \
    echo "extension=$PHP_EXTENSIONS_DIR/dbase.so" > /usr/local/etc/php/conf.d/ext-dbase.ini

# Install ZipArchive
RUN docker-php-ext-install zip

# Install Extra PHP Libs
RUN docker-php-ext-install intl

# Soap
RUN docker-php-ext-install soap

# Install Sodium
#RUN pecl install libsodium && \
#    echo "extension=$PHP_EXTENSIONS_DIR/libsodium.so" > /usr/local/etc/php/conf.d/ext-sodium.ini

# Install xdebug
RUN pecl install xdebug && \
    echo "zend_extension=$PHP_EXTENSIONS_DIR/xdebug.so" > /usr/local/etc/php/conf.d/ext-xdebug.ini \
   && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/ext-xdebug.ini \
   && echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/ext-xdebug.ini \
   && echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/ext-xdebug.ini \
   && echo "xdebug.remote_port=9001" >> /usr/local/etc/php/conf.d/ext-xdebug.ini \
   && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/ext-xdebug.ini \
   && echo "xdebug.idekey=docker" >> /usr/local/etc/php/conf.d/ext-xdebug.ini

# Install mongo
RUN pecl install mongodb && \
    echo "extension=$PHP_EXTENSIONS_DIR/mongodb.so" > /usr/local/etc/php/conf.d/ext-mongodb.ini

# Install redis
ENV PHPREDIS_VERSION 3.0.0
RUN curl -k -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
    && docker-php-ext-install redis

# phpunit
RUN wget https://phar.phpunit.de/phpunit-5.7.phar && \
    mv phpunit-5.7* /usr/bin/phpunit && \
    chmod +x /usr/bin/phpunit

# phpmd
RUN wget -c http://static.phpmd.org/php/latest/phpmd.phar && \
    mv phpmd.phar /usr/bin/phpmd && \
    chmod +x /usr/bin/phpmd

# composer
RUN curl -sS http://getcomposer.org/installer | php && \
    mv composer.phar /usr/bin/composer && \
    chmod +x /usr/bin/composer

# php7cc
RUN composer global require sstalle/php7cc && \
    export PATH="$PATH:$HOME/.composer/vendor/bin"

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
		docker-php-ext-install gd

# conf files
COPY conf/php-fpm.conf /usr/local/etc/
COPY conf/php.ini /usr/local/etc/php/
COPY conf/www.conf /etc/php5/fpm/pool.d/www.conf

WORKDIR /var/www/html

EXPOSE 9000
CMD ["php-fpm"]
