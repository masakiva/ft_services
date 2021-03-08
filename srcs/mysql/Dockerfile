FROM alpine:3.13

RUN apk update
RUN apk add mariadb=10.5.8-r0 mariadb-client=10.5.8-r0
RUN apk add openrc=0.42.1-r19

EXPOSE 3306

COPY user_and_db.sql .
COPY wordpress.sql .
COPY init_mariadb.sh .

CMD ["./init_mariadb.sh"]
