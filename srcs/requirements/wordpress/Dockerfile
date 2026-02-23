# Use official PHP 8.1 FPM Alpine image
FROM php:8.1-fpm-alpine

# Set working directory
WORKDIR /var/www/html

# Install required PHP extensions and utilities
RUN apk update && apk add --no-cache \
    bash \
    curl \
    wget \
    libzip-dev \
    oniguruma-dev \
    zip \
    unzip \
    && docker-php-ext-install mysqli pdo pdo_mysql zip mbstring exif pcntl \
    && rm -rf /var/cache/apk/*

# Download WordPress
RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz \
    && rm latest.tar.gz \
    && mv wordpress/* . \
    && rm -rf wordpress

# Copy wp-config.php
COPY wp-config.php /var/www/html/wp-config.php

# Copy startup script
COPY script.sh /script.sh
RUN chmod +x /script.sh

# Expose PHP-FPM port
EXPOSE 9000

# Start container
CMD ["/script.sh"]
