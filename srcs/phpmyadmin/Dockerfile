FROM alpine:3.13

RUN apk update
RUN apk add nginx=1.18.0-r13
RUN apk add phpmyadmin=5.0.4-r0

EXPOSE 5000

COPY nginx_php.conf .
COPY init_php.sh .

CMD ["./init_php.sh"]
