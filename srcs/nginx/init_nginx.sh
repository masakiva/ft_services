#!/bin/sh

# the following two paragraphs have been originally
# copied from https://wiki.alpinelinux.org/wiki/Nginx

# -D don't assign a password, -g GECOS field
#adduser -D -g 'www' www
# for html page source
#mkdir /www
#chown -R www:www /var/lib/nginx/
#chown -R www:www /www

mv nginx.conf /etc/nginx/
#mv index.html /www/

# nginx asks for this file in order to start
mkdir /run/nginx
touch /run/nginx/nginx.pid

# setup SSL
mkdir -p /etc/ssl/private ; mkdir -p /etc/ssl/certs
cat setup_openssl | openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/ssl/private/nginx-selfsigned.key \
		-out /etc/ssl/certs/nginx-selfsigned.crt 2> /dev/null
rm setup_openssl

nginx
