FROM mariadb:10.5

USER root

RUN id "mysql" &>/dev/null && userdel mysql || true \
    && useradd -u 999 mysql || true \
    && mkdir -p /data/mysql \
    && chown -R mysql:mysql /data/mysql

EXPOSE 3306

CMD ["mysqld"]
