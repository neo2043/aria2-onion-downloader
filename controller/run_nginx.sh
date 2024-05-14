#!/bin/sh
set -e

exec ls /conf

if [ ! -f "/conf/nginx.conf" ]; then
    echo "config file not found. using default config."
    cp -r /bak/conf/nginx.conf /conf
fi

exec ls /conf

exec nginx -c /conf/nginx.conf -g 'daemon off;'