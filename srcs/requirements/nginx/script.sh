#!/bin/bash

echo "Starting NGINX..."

mkdir -p /var/www/html

nginx -t
if [ $? -ne 0 ]; then
    echo "NGINX configuration test failed"
    exit 1
fi

exec nginx -g "daemon off;"
