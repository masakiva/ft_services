FROM alpine:3.13

RUN apk update
RUN apk add nginx=1.18.0-r13
RUN apk add openssl=1.1.1j-r0
RUN apk add php7-fpm=7.4.15-r0
RUN apk add phpmyadmin=5.0.4-r0

EXPOSE 5000

COPY nginx.conf /etc/nginx/
COPY setup_openssl .
COPY config.inc.php /etc/phpmyadmin/
COPY init.sh .

CMD ["./init.sh"]
