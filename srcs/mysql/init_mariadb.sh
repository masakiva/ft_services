#!/bin/sh

mariadb-install-db --user='mysql' --datadir='/var/lib/mysql'

sed -i 's/skip-networking/#skip-networking/' /etc/my.cnf.d/mariadb-server.cnf

rc-status
touch /run/openrc/softlevel
rc-service mariadb start

mariadb < user_and_db.sql
mariadb < wordpress.sql

tail -f /dev/null
