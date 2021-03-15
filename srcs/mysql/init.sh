#!/bin/sh

sed -i 's/skip-networking/#skip-networking/' /etc/my.cnf.d/mariadb-server.cnf

if [ ! -d /var/lib/mysql/wp_db ]
then
	cp -Rp /var/lib/mysql-on-image/* /var/lib/mysql
fi

rc-status
# openrc asks for this file
touch /run/openrc/softlevel
rc-service mariadb start

tail -f /dev/null
