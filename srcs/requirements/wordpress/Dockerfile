FROM php:8.1-fpm-alpine

WORKDIR /var/www/html

RUN apk update && apk add --no-cache \
    bash \
    curl \
    wget \
    libzip-dev \
    oniguruma-dev \
    zip \
    unzip \
    mariadb-client \
    && docker-php-ext-install mysqli pdo pdo_mysql zip mbstring exif pcntl \
    && rm -rf /var/cache/apk/*

# Install WP-CLI
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

# Copy startup script
COPY script.sh /script.sh
RUN chmod +x /script.sh

EXPOSE 9000

CMD ["/script.sh"]
