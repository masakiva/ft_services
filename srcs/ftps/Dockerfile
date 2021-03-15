FROM alpine:3.13

RUN apk update
RUN apk add vsftpd=3.0.3-r6
RUN apk add openssl=1.1.1j-r0

EXPOSE 21 40000 40001 40002 40003 40004

COPY vsftpd.conf /etc/vsftpd/
COPY init.sh .

CMD ["./init.sh"]
