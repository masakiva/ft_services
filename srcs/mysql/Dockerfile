FROM alpine:3.13

RUN apk update
RUN apk add mariadb=10.5.8-rj

COPY setup_db.sql .

CMD ["./init_mariadb.sh"]
