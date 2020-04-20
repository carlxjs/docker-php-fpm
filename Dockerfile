FROM php:7.2-fpm-alpine3.11

RUN apk add --no-cache libpng libpng-dev && docker-php-ext-install gd \
&& docker-php-ext-install opcache pdo_mysql \
# Add default php.ini file
&& cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini \
# install xdebug
&& apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
&& pecl install xdebug \
&& docker-php-ext-enable xdebug \
&& apk del .build-deps \
# install composer
&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
# install drush
&& composer global require drush/drush
