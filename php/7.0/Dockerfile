# Based on the Dockerfile from the docker-library.
# - version updated to 5.5.21
# - sqlite support removed
# - pgsql support added.

FROM debian:jessie

# Custom Dockerfile
MAINTAINER Ricardo Sierra <ricardo@ricardosierra.com.br>
MAINTAINER Daniel Pinto <cayan@programmer.net>
MAINTAINER Claydionei <claydionei@fidelize.com.br>

ENV PHP_INI_DIR /usr/local/etc/php
RUN mkdir -p $PHP_INI_DIR/conf.d

ENV PHP_EXTRA_BUILD_DEPS 
ENV PHP_EXTRA_CONFIGURE_ARGS --enable-mbstring --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data

ENV GPG_KEYS 1A4E8B7277C42E53DBA9C7B9BCAA30EA9C0D5763
RUN set -xe \
	&& for key in $GPG_KEYS; do \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
	done

ENV PHP_VERSION 7.1.0
ENV PHP_FILENAME php-7.0.1.tar.xz
ENV PHP_SHA256 84fcb8b9c61f70db802d3b6636c6ba602470a375e593375c0c744483aa0c0357

# --enable-mysqlnd is included below because it's harder to compile after the fact the extensions are (since it's a plugin for several extensions, not an extension in itself)
RUN buildDeps=" \
		$PHP_EXTRA_BUILD_DEPS \
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
                libpng12-0 \
                libbz2-dev \
		librecode0 \
		libsqlite3-0 \
                libgearman-dev \
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
                vim \
                nano \
                telnet \
                netstat-nat \
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
	&& apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $buildDeps \
	&& make clean

# Docker PHP EXT BIN
COPY build/docker-php-ext-* /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-php-ext-*

# Postgres
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/include/postgresql/
RUN docker-php-ext-install pgsql pdo_pgsql

# Install Gearman
RUN cd /root/ && \
    wget https://github.com/wcgallego/pecl-gearman/archive/master.zip && \
    unzip master.zip && \
    cd pecl-gearman-master && \
    phpize  && \
    ./configure  && \
    make install  && \
    cp /root/pecl-gearman-master/modules/gearman.so/usr/local/lib/php/extensions/no-debug-non-zts-20151012/gearman.so && \
    echo "/usr/local/lib/php/extensions/no-debug-non-zts-20151012/gearman.so" > /usr/local/etc/php/conf.d/gearman.ini

# Install ZipArchive
RUN pecl install zip &&\
    docker-php-ext-install zip

# Install Extra PHP Libs
docker-php-ext-install ast
docker-php-ext-install intl

# Install xdebug
RUN pecl install xdebug &&\
    echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20121212/xdebug.so" > /usr/local/etc/php/conf.d/ext-xdebug.ini

# Install mongo
RUN pecl install mongodb &&\
    echo "extension=/usr/local/lib/php/extensions/no-debug-non-zts-20151012/mongodb.so" > /usr/local/etc/php/conf.d/ext-mongodb.ini

# Install redis
ENV PHPREDIS_VERSION 3.0.0
RUN curl -k -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
    && docker-php-ext-install redis

# phpunit
RUN wget --no-check-certificate https://phar.phpunit.de/phpunit.phar
RUN mv phpunit.phar /usr/bin/phpunit
RUN chmod +x /usr/bin/phpunit

# phpmd
RUN wget -c http://static.phpmd.org/php/latest/phpmd.phar
RUN mv phpmd.phar /usr/bin/phpmd
RUN chmod +x /usr/bin/phpmd

# composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/bin/composer
RUN chmod +x /usr/bin/composer

# conf files
COPY conf/php-fpm.conf /usr/local/etc/
COPY conf/php.ini /usr/local/etc/php/
COPY conf/www.conf /etc/php5/fpm/pool.d/www.conf

WORKDIR /var/www/html

EXPOSE 9000
CMD ["php-fpm"]