#!/bin/sh

# Lê as senhas dos arquivos de secrets
MYSQL_PASSWORD=$(cat "$MYSQL_PASSWORD_FILE")
MYSQL_ROOT_PASSWORD=$(cat "$MYSQL_ROOT_PASSWORD_FILE")

# Create the initialization SQL file at /db1.sql

cat <<EOF > /db1.sql
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

# If an admin user is defined, add its creation and privileges
if [ -n "$MYSQL_ADMIN_USER" ]; then
cat <<EOF >> /db1.sql
CREATE USER IF NOT EXISTS '$MYSQL_ADMIN_USER'@'%' IDENTIFIED BY '$MYSQL_ADMIN_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_ADMIN_USER'@'%';
FLUSH PRIVILEGES;
EOF
fi

# Initialize the database if not already created
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing the database..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB in the foreground using the init file
mariadbd --user=mysql --datadir=/var/lib/mysql --init-file=/db1.sql
