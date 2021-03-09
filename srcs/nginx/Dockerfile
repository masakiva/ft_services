FROM alpine:3.13

RUN apk update
RUN apk add nginx=1.18.0-r13
RUN apk add openssl=1.1.1j-r0

EXPOSE 80
EXPOSE 443

COPY nginx.conf .
#COPY index.html .
COPY setup_openssl .
COPY init.sh .

CMD ["./init.sh"]
