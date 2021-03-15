FROM alpine:3.13

RUN apk update
RUN apk add mariadb=10.5.8-r0 mariadb-client=10.5.8-r0
RUN apk add openrc=0.42.1-r19

# install first in /var/lib/mysql-on-image directory, on build time
# then copy files in /var/lib/mysql directory, on which persistent volume is mounted
RUN mariadb-install-db --user='mysql' --datadir='/var/lib/mysql-on-image'
COPY user_and_db.sql .
COPY wordpress.sql .
RUN mariadbd-safe --datadir='/var/lib/mysql-on-image' & sleep 20 ; \
							mariadb < user_and_db.sql ; \
							mariadb < wordpress.sql ; \
							rm user_and_db.sql wordpress.sql

EXPOSE 3306

COPY init.sh .

CMD ["./init.sh"]
