FROM alpine:3.13

RUN apk update
RUN apk add nginx=1.18.0-r13
RUN apk add openssl=1.1.1j-r0
RUN apk add php7-fpm=7.4.15-r0
RUN apk add php7-common php7-iconv php7-json php7-gd php7-curl php7-xml \
		php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql \
		php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap \
		php7-ctype php7-dom

RUN wget https://wordpress.org/wordpress-5.6.2.tar.gz
RUN mkdir -p /usr/share/webapps ; \
		tar -C /usr/share/webapps/ -xzf wordpress-5.6.2.tar.gz ; \
		rm wordpress-5.6.2.tar.gz

EXPOSE 5050

COPY nginx.conf .
COPY setup_openssl .
COPY wp-config.php .
COPY init.sh .

CMD ["./init.sh"]
