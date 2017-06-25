# Based on the Dockerfile from the docker-library.
# - version updated to 5.5.21
# - sqlite support removed
# - pgsql support added.
# - mssql support added.
# - redis support added.

FROM debian:jessie

# Custom Dockerfile
MAINTAINER Ricardo Sierra <ricardo@ricardosierra.com.br>

ENV PHP_INI_DIR /usr/local/etc/php
RUN mkdir -p $PHP_INI_DIR/conf.d

ENV PHP_EXTRA_BUILD_DEPS php7.0-sybase php7.0-soap
ENV PHP_EXTRA_CONFIGURE_ARGS --enable-mbstring --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data

ENV GPG_KEYS 1A4E8B7277C42E53DBA9C7B9BCAA30EA9C0D5763
RUN set -xe \
	&& for key in $GPG_KEYS; do \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
	done

ENV PHP_VERSION 7.0.13
ENV PHP_FILENAME php-7.0.13.tar.xz
ENV PHP_SHA256 357ba7f93975d7d836abed0852dc3ed96a988af539e87750613294cbee82f1bf

# Para incluir apt zip e unzip
RUN echo "deb http://ftp.debian.org/debian/ jessie-updates main contrib non-free" >> /etc/apt/sources.list
# Repositorio para PHP7
RUN gpg --keyserver keys.gnupg.net --recv-key 89DF5277 && \
gpg -a --export 89DF5277 | apt-key add - && \
echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list

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
    # unixodbc unixodbc-dev tdsodbc \ # MSSQL
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
    cp /root/pecl-gearman-master/modules/gearman.so /usr/local/lib/php/extensions/no-debug-non-zts-20151012/gearman.so && \
    echo "extension=/usr/local/lib/php/extensions/no-debug-non-zts-20151012/gearman.so" > /usr/local/etc/php/conf.d/ext-gearman.ini

# Install ZipArchive
RUN pecl install zip && \
    docker-php-ext-install zip

# Install FTP
RUN docker-php-ext-install ftp

# Install GD
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd

# Install SqlServer Support
#RUN pecl install sqlsrv && \
#    pecl install pdo_sqlsrv && \
#    echo "extension=$(find /usr/local/lib/php/extensions/ -name sqlsrv.so)" > /usr/local/etc/php/conf.d/ext-sqlsrv.ini && \
#    echo "extension=$(find /usr/local/lib/php/extensions/ -name pdo_sqlsrv.so)" > /usr/local/etc/php/conf.d/ext-pdo_sqlsrv.ini

# Install Extra PHP Libs - Multi Linguagens
RUN docker-php-ext-install intl

# Soap
RUN docker-php-ext-install soap

# Install Sodium
RUN pecl install libsodium && \
    echo "extension=/usr/local/lib/php/extensions/no-debug-non-zts-20151012/libsodium.so" > /usr/local/etc/php/conf.d/ext-sodium.ini

# Install xdebug
RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini

# Install mongodb
RUN pecl install mongodb && \
    echo "extension=/usr/local/lib/php/extensions/no-debug-non-zts-20151012/mongodb.so" > /usr/local/etc/php/conf.d/ext-mongodb.ini
	
# Install redis
ENV PHPREDIS_VERSION 3.0.0
RUN curl -k -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
    && docker-php-ext-install redis

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
