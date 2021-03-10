#!/bin/sh

sed -i 's/skip-networking/#skip-networking/' /etc/my.cnf.d/mariadb-server.cnf

if [ ! -d /var/lib/mysql/wp_db ]
then
	cp -Rp /var/lib/mysql-on-image/* /var/lib/mysql
fi

mariadbd-safe --datadir='/var/lib/mysql'
