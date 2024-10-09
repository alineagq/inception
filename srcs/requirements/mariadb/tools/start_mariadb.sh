#!/bin/sh

# Start MariaDB


echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE ;" > db1.sql
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> db1.sql
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' ;" >> db1.sql
echo "ALTER USER '$MYSQL_ROOT_USER'@'wordpress.srcs_inception' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' ;" >> db1.sql
echo "FLUSH PRIVILEGES;" >> db1.sql

sleep 8

mariadbd-safe < db1.sql

mariadbd-safe -F
