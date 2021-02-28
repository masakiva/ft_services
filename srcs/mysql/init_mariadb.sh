#!/bin/sh

mariadb-install-db --user=mysql --datadir=/var/lib/mysql
#cd '/usr'
/usr/bin/mariadbd-safe --datadir='/var/lib/mysql' &
echo

sleep 0.1
echo -n 'Waiting for mariadb to launch'
while [ `ps | grep mariadbd | wc -l` != 2 ]; do
	echo -n .
	sleep 0.3
done
echo
mariadb < wordpress_database.sql

sh
