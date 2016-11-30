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

ENV PHP_EXTRA_BUILD_DEPS php5-intl
ENV PHP_EXTRA_CONFIGURE_ARGS --enable-mbstring --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data

ENV GPG_KEYS 0B96609E270F565C13292B24C13C70B87267B52D 0BD78B5F97500D450838F95DFE857D9A90D90EC1 F38252826ACD957EF380D39F2F7956BC5DA04B5D
RUN set -xe \
	&& for key in $GPG_KEYS; do \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
	done

ENV PHP_VERSION 5.6.28



# --enable-mysqlnd is included below because it's harder to compile after the fact the extensions are (since it's a plugin for several extensions, not an extension in itself)
RUN buildDeps=" \
		$PHP_EXTRA_BUILD_DEPS \
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
                tar \
	" \
	&& set -x \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
	&& curl -SL --insecure "http://br1.php.net/get/php-$PHP_VERSION.tar.xz/from/this/mirror" -o php.tar.xz \
	&& curl -SL --insecure "http://br1.php.net/get/php-$PHP_VERSION.tar.xz.asc/from/this/mirror" -o php.tar.xz.asc \
	&& mkdir -p /usr/src/php \
	&& tar -xof php.tar.xz -C /usr/src/php --strip-components=1 \
	&& rm php.tar.xz* \
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
                --with-bz2 \
	&& make -j"$(nproc)" \
	&& make install \
	&& { find /usr/local/bin /usr/local/sbin -type f -executable -exec strip --strip-all '{}' + || true; } \
	#&& apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $buildDeps \
	&& make clean

# Docker PHP EXT BIN
COPY build/docker-php-ext-* /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-php-ext-*

# Postgres
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/include/postgresql/ && \
    docker-php-ext-install pgsql pdo_pgsql intl

# Install ZipArchive
RUN pecl install zip &&\
    docker-php-ext-install zip

# Install Extra PHP Libs
RUN docker-php-ext-install intl

# Install xdebug
RUN pecl install xdebug && \
    echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20121212/xdebug.so" > /usr/local/etc/php/conf.d/ext-xdebug.ini

# Install mongo
RUN pecl install mongo && \
    echo "extension=/usr/local/lib/php/extensions/no-debug-non-zts-20121212/mongo.so" > /usr/local/etc/php/conf.d/ext-mongo.ini

# Install redis
ENV PHPREDIS_VERSION 2.2.7
RUN curl -k -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
    && docker-php-ext-install redis

# Install Extra PHP Libs
RUN docker-php-ext-install intl

# phpunit
RUN wget --no-check-certificate http://phar.phpunit.de/phpunit.phar && \
    mv phpunit.phar /usr/bin/phpunit && \
    chmod +x /usr/bin/phpunit

# phpmd
RUN wget -c http://static.phpmd.org/php/latest/phpmd.phar && \
    mv phpmd.phar /usr/bin/phpmd && \
    chmod +x /usr/bin/phpmd

# composer
RUN curl -sS http://getcomposer.org/installer | php && \
    mv composer.phar /usr/bin/composer && \
    chmod +x /usr/bin/composer

# conf files
COPY conf/php-fpm.conf /usr/local/etc/
COPY conf/php.ini /usr/local/etc/php/
COPY conf/www.conf /etc/php5/fpm/pool.d/www.conf

WORKDIR /var/www/html

EXPOSE 9000
CMD ["php-fpm"]