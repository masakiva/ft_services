#!/bin/sh

until mariadb
do
	sleep 0.3
done
sleep 1

mariadb < user_and_db.sql
mariadb < wordpress.sql
