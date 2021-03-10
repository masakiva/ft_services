FROM alpine:3.13

RUN apk update
RUN apk add mariadb=10.5.8-r0 mariadb-client=10.5.8-r0

RUN mariadb-install-db --user='mysql' --datadir='/var/lib/mysql-on-image'
COPY user_and_db.sql .
COPY wordpress.sql .
RUN mariadbd-safe --datadir='/var/lib/mysql-on-image' & sleep 20 ; \
							mariadb < user_and_db.sql ; \
							mariadb < wordpress.sql

EXPOSE 3306

COPY init.sh .

CMD ["./init.sh"]
