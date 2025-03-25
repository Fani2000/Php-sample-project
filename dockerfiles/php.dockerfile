FROM php:8.2.4-fpm-alpine

WORKDIR /var/www/html

RUN docker-php-ext-install pdo pdo_mysql

# Create 'laravel' user and group
RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

# Ensure correct permissions for storage and cache directories
COPY --chown=laravel:laravel . /var/www/html

RUN mkdir -p storage/framework/cache && \
    mkdir -p storage/framework/sessions && \
    mkdir -p storage/framework/views && \
    mkdir -p bootstrap/cache && \
    chown -R laravel:laravel storage bootstrap/cache && \
    chmod -R 775 storage bootstrap/cache

USER laravel