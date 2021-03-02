#!/bin/sh

mv nginx_php.conf /etc/nginx/nginx.conf
mv config.inc.php /etc/phpmyadmin/config.inc.php

# nginx asks for this file in order to start
mkdir /run/nginx
touch /run/nginx/nginx.pid

php-fpm7
nginx
