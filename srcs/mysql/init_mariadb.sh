#!/bin/sh

mariadb-install-db --user='mysql' --datadir='/var/lib/mysql'
sed -i 's/skip-networking/#skip-networking/' /etc/my.cnf.d/mariadb-server.cnf
mariadbd-safe --datadir='/var/lib/mysql' &
sleep 1

until mariadb &
do
	echo -n .
	sleep 0.3
done
sleep 1
mariadb < wordpress_database.sql
tail -f /dev/null
