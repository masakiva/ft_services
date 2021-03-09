#!/bin/sh

mariadb-install-db --user='mysql' --datadir='/var/lib/mysql'
sed -i 's/skip-networking/#skip-networking/' /etc/my.cnf.d/mariadb-server.cnf
mariadbd-safe --datadir='/var/lib/mysql' &
sleep 1

nohup ./import_wp_tables.sh &

#rc-status
#touch /run/openrc/softlevel
#rc-service mariadb start

tail -f /dev/null
