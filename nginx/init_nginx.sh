#!/bin/sh

adduser -D -g 'www' www
mkdir /www
chown -R www:www /var/lib/nginx/
chown -R www:www /www
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
mv simple-nginx.conf /etc/nginx/nginx.conf
mv simple-index.html /www/index.html
mkdir /run/nginx
touch /run/nginx/nginx.pid
# setup SSL
mkdir -p /etc/ssl/private ; mkdir -p /etc/ssl/certs ; \
		cat setup_openssl | openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/ssl/private/nginx-selfsigned.key \
		-out /etc/ssl/certs/nginx-selfsigned.crt 2> /dev/null

#nginx
sh
