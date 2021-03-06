FROM php:7.4.8-fpm-alpine3.12

# install gd
RUN apk add --no-cache libpng libpng-dev && \
    docker-php-ext-install gd \
# install some other php extension we need
&& docker-php-ext-install opcache pdo_mysql \
# add default php.ini file
&& cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
# install composer
&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
# install git
&& apk add --no-cache git \
# install node or npm
&& apk add --no-cache npm