#!/bin/sh

mariadb-install-db --user='mysql' --datadir='/var/lib/mysql'
mariadbd-safe --datadir='/var/lib/mysql' &
sleep 1

until mariadb &
do
	echo -n .
	sleep 0.3
done
mariadb < wordpress_database.sql
