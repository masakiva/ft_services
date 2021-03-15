FROM alpine:3.13

RUN apk update
RUN apk add influxdb=1.8.3-r2 telegraf=1.17.0-r0

EXPOSE 8086

COPY telegraf.conf /etc/telegraf/
COPY init.sh .

CMD ["./init.sh"]
