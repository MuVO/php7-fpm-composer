FROM php:7-fpm-alpine

ARG UID="www-data"
ARG GID="www-data"

RUN apk add autoconf bzip2-dev gcc git icu-dev imagemagick-dev libc-dev libjpeg-turbo-dev libpng-dev libzip-dev libmemcached-dev make postgresql-dev zlib-dev \
	&& docker-php-ext-configure gd --with-jpeg \
	&& docker-php-ext-install -j$(nproc) bcmath bz2 gd intl json pcntl pdo_mysql pdo_pgsql sockets zip \
	&& pecl install imagick memcached mongodb redis ; docker-php-ext-enable imagick memcached mongodb redis \
	&& rm -rfv /var/cache/apk/* \
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
	&& php -i

USER ${UID}
