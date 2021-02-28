#!/bin/sh

# the following two paragraphs have been originally
# copied from https://wiki.alpinelinux.org/wiki/Nginx

# -D don't assign a password, -g GECOS field
adduser -D -g 'www' www
# for html page source
chown -R www:www /var/lib/nginx/
chown -R www:www /usr/share/webapps/phpmyadmin

mv /etc/nginx/nginx.conf /etc/nginx/nginx-default.conf
mv nginx_php.conf /etc/nginx/nginx.conf

# nginx asks for this file in order to start
mkdir /run/nginx
touch /run/nginx/nginx.pid

#nginx

sh
