#!/bin/sh

cd /var/www/wordpress

# Lê as senhas dos arquivos de secrets
WP_DB_PASSWORD=$(cat "$WP_DB_PASSWORD_FILE")
WP_ADMIN_PASSWORD=$(cat "$WP_ADMIN_PASSWORD_FILE")

# Baixa o WordPress se os arquivos não existirem
if [ ! -f index.php ]; then
    echo "Baixando WordPress..."
    wp core download --allow-root
fi

# Remove a porta do WP_DB_HOST se necessário (i.e., "mariadb:3306" -> "mariadb")
WP_DB_HOST=$(echo "$WP_DB_HOST" | cut -d: -f1)

# Espera até que o banco de dados esteja acessível
while ! mysqladmin ping -h"$WP_DB_HOST" -u"$WP_DB_USER" -p"$WP_DB_PASSWORD" --silent; do
    echo "Aguardando MariaDB em $WP_DB_HOST..."
    sleep 1
done

# Se o wp-config.php não existir, cria um novo
if [ ! -f wp-config.php ]; then
    echo "Gerando wp-config.php..."
    wp config create --dbname="$WP_DB_NAME" \
                     --dbuser="$WP_DB_USER" \
                     --dbpass="$WP_DB_PASSWORD" \
                     --dbhost="$WP_DB_HOST" \
                     --allow-root
fi

# Se o WordPress não estiver instalado, instala
if ! wp core is-installed --allow-root; then
    echo "Instalando WordPress..."
    wp core install --url="$WP_URL" \
                    --title="$WP_TITLE" \
                    --admin_user="$WP_ADMIN" \
                    --admin_password="$WP_ADMIN_PASSWORD" \
                    --admin_email="$WP_ADMIN_EMAIL" \
                    --allow-root
fi

# Ajusta permissões
chown -R nobody:nobody /var/www/wordpress
chmod -R 755 /var/www/wordpress

# Inicia o PHP-FPM
php-fpm82 -F
