FROM alpine:3.13

RUN apk update
RUN apk add influxdb=1.8.3-r2

EXPOSE 8086

COPY init.sh .

CMD ["./init.sh"]
