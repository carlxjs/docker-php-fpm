FROM php:7.2-fpm-alpine3.11

RUN apk add --no-cache libpng libpng-dev && docker-php-ext-install gd \
&& docker-php-ext-install opcache pdo_mysql \
# add default php.ini file
&& cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini \
# install xdebug
&& apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
&& pecl install xdebug \
&& docker-php-ext-enable xdebug \
&& apk del .build-deps \
# install drush launcher
curl -fsSL -o /usr/local/bin/drush "https://github.com/drush-ops/drush-launcher/releases/download/$DRUSH_VERSION/drush.phar" && \
    chmod +x /usr/local/bin/drush \
# install drupal console
&& curl https://drupalconsole.com/installer -L -o drupal.phar && \
    mv drupal.phar /usr/local/bin/drupal && \
    chmod +x /usr/local/bin/drupal \
# install composer
&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
# use composer install drush global
&& composer global require drush/drush \
$$ composer clearcache \
# add composer bin in ~/.profile
&& echo "export PATH=~/.composer/vendor/bin:$PATH" >> ~/.profile \
# install mariadb client for used drush
&& apk add --no-cache mariadb-client
