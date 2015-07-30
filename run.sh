#!/bin/bash

sed -i'' "s|{HOSTNAME}|${HOSTNAME}|" /etc/supervisor/supervisord.conf

mkdir -pv /var/log/supervisor/${HOSTNAME}

exec supervisord -n -c /etc/supervisor/supervisord.conf