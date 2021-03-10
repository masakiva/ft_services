FROM alpine:3.13

RUN apk update
RUN apk add grafana=7.3.6-r0

EXPOSE 3000

COPY init.sh .

CMD ["./init.sh"]
