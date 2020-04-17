FROM php:7.2-fpm-alpine3.11

RUN apk add --no-cache \
        libpng \
        libpng-dev \
        && \
docker-php-ext-install \
gd \
opcache \
pdo_mysql