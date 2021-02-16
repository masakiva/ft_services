FROM alpine:3.13

RUN apk update
RUN apk add nginx=1.18.0-r13
RUN apk add openssl=1.1.1i-r0

COPY nginx.conf .
COPY index.html .
COPY init_nginx.sh .
COPY setup_openssl .

EXPOSE 80
EXPOSE 443

CMD ["./init_nginx.sh"]
