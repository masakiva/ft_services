#!/bin/sh

sed -i 's/skip-networking/#skip-networking/' /etc/my.cnf.d/mariadb-server.cnf

rc-status
touch /run/openrc/softlevel
rc-service mariadb start

mariadb < wordpress_database.sql

tail -f /dev/null
