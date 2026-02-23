#!/bin/sh
set -e

echo "Starting MariaDB..."

# Init DB if empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

echo "Starting MariaDB (temporary)..."
mariadbd --user=mysql --datadir=/var/lib/mysql --skip-networking &
pid="$!"

# Wait for MariaDB
echo "Waiting for MariaDB to be ready..."
until mysqladmin ping --silent; do
    sleep 1
done

echo "MariaDB is up!"

# Setup database and user
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

echo "Stopping temporary MariaDB..."
mysqladmin shutdown

echo "Starting MariaDB in foreground..."
exec mariadbd --user=mysql --datadir=/var/lib/mysql
