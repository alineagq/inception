FROM alpine:3.19.4

RUN apk update && \
    apk upgrade && \
    apk add	mariadb mariadb-client

COPY tools/mariadb-server.cnf /etc/my.cnf

RUN mkdir -p /var/lib/mysql /var/log/mysqld /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /var/log/mysqld /var/run/mysqld

# Initialize the database

COPY tools/start_mariadb.sh /usr/bin/start_mariadb.sh

RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql

RUN chmod +x /usr/bin/start_mariadb.sh

EXPOSE 3306

ENTRYPOINT [ "/usr/bin/start_mariadb.sh" ]
