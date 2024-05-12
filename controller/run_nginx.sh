#!/bin/sh
set -e

if [ ! -f "/conf/nginx.conf" ]; then
    echo "config file not found. using default config."
    cp -r /bak/conf /conf
fi

exec nginx -c /conf/nginx.conf -g 'daemon off;'