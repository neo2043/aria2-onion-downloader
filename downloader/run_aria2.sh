#!/bin/sh
set -e

exec ls /conf

if [ ! -f "/conf/aria2.conf" ]; then
    echo "config file not found. using default config."
    cp -r /bak/conf /conf
fi

exec ls /conf

touch /conf/aria2.session
touch /log/aria2_log.txt

python /home/creatorrc/creatorrc.py --speetor && mv -f tor_config.txt /conf/torrc && tor --runasdaemon 1 -f /conf/torrc || tor --runasdaemon 1

exec v2ray run -c /conf/config.json &
exec aria2c --conf-path=/conf/aria2.conf --log=/log/aria2_log.txt --rpc-listen-port=${RPCPORT} --rpc-secret=${RPCSECRET}

