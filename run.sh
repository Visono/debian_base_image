#!/bin/bash

sed -i'' "s|{HOSTNAME}|${HOSTNAME}|" /etc/supervisor/supervisord.conf

mkdir -v /var/log/supervisor/${HOSTNAME}

exec supervisord -n -c /etc/supervisor/supervisord.conf