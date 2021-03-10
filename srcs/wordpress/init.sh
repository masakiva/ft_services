#!/bin/sh

mv nginx.conf /etc/nginx/nginx.conf
mv wp-config.php /usr/share/webapps/wordpress/wp-config.php

# nginx asks for this file in order to start
mkdir /run/nginx
touch /run/nginx/nginx.pid

# setup SSL
mkdir -p /etc/ssl/private ; mkdir -p /etc/ssl/certs
cat setup_openssl | openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/ssl/private/nginx-selfsigned.key \
		-out /etc/ssl/certs/nginx-selfsigned.crt 2> /dev/null
rm setup_openssl

php-fpm7
nginx
