FROM alpine:3.13

RUN apk update
RUN apk add nginx=1.18.0-r13
RUN apk add phpmyadmin=5.0.4-r0 php7-fpm=7.4.15-r0

EXPOSE 5000

COPY nginx_wordpress.conf .
COPY init_wordpress.sh .

CMD ["./init_wordpress.sh"]
