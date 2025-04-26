#!/bin/sh

# Create the initialization SQL file at /db1.sql

cat <<EOF > /db1.sql
CREATE DATABASE IF NOT EXISTS $WP_DB_NAME;
CREATE USER IF NOT EXISTS '$WP_DB_USER'@'%' IDENTIFIED BY '$WP_DB_PASSWORD';
GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_DB_USER'@'%';
FLUSH PRIVILEGES;
EOF

# Initialize the database if not already created
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing the database..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB in the foreground using the init file
mariadbd --user=mysql --datadir=/var/lib/mysql --init-file=/db1.sql
