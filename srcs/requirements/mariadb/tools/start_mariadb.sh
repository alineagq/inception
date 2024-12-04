#!/bin/sh

# Criar script SQL para configuração do MariaDB
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE ;" > db1.sql
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'wordpress' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> db1.sql
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'wordpress' ;" >> db1.sql
echo "FLUSH PRIVILEGES;" >> db1.sql

# Iniciar MariaDB
mariadbd-safe --datadir=/var/lib/mysql &
sleep 8

# Executar script SQL
mariadb -u root -p"$MYSQL_ROOT_PASSWORD" < db1.sql

# Verificar conectividade do banco de dados
until mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -h"mariadb" -e "SELECT 1;" >/dev/null 2>&1; do
    echo "Waiting for MariaDB to accept connections..."
    sleep 2
done

echo "MariaDB setup complete."
