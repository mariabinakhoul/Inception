#!/bin/sh
set -e

# Wait for MariaDB to be ready
until mysqladmin ping -h "${WORDPRESS_DB_HOST}" -u "${WORDPRESS_DB_USER}" -p"${WORDPRESS_DB_PASSWORD}" --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

# Download WordPress core if not already present
if [ ! -f /var/www/html/wp-login.php ]; then
    wp core download --allow-root --path=/var/www/html
fi

# Create wp-config.php if not already present
if [ ! -f /var/www/html/wp-config.php ]; then
    wp config create \
        --allow-root \
        --path=/var/www/html \
        --dbname="${WORDPRESS_DB_NAME}" \
        --dbuser="${WORDPRESS_DB_USER}" \
        --dbpass="${WORDPRESS_DB_PASSWORD}" \
        --dbhost="${WORDPRESS_DB_HOST}"
fi

# Install WordPress if not already installed
if ! wp core is-installed --allow-root --path=/var/www/html; then
    wp core install \
        --allow-root \
        --path=/var/www/html \
        --url="https://mabi-nak.42.fr" \
        --title="Inception" \
        --admin_user="mabi-nak" \
        --admin_password="${WORDPRESS_DB_PASSWORD}" \
        --admin_email="mabi-nak@student.42.fr" \
        --skip-email

    # Create second regular user
    wp user create editor editor@student.42.fr \
        --allow-root \
        --path=/var/www/html \
        --role=editor \
        --user_pass="${WORDPRESS_DB_PASSWORD}"
fi

exec php-fpm -F