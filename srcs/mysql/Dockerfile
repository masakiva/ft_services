FROM alpine:3.13

RUN apk update
RUN apk add mariadb=10.5.8-r0 mariadb-client=10.5.8-r0

COPY wordpress_database.sql .
COPY init_mariadb.sh .

CMD ["./init_mariadb.sh"]
