#!/bin/sh

# Configurações
cd /var/www/wordpress

# Verifica se o WordPress está instalado
if ! wp core is-installed --allow-root; then
    echo "WordPress not installed yet"

    # Gera o arquivo wp-config.php
    wp core config  --dbname=$WP_DB_NAME \
                    --dbuser=$WP_DB_USER \
                    --dbpass=$WP_DB_PASSWORD \
                    --dbhost=$WP_DB_HOST \
                    --allow-root \
                    --dbprefix=$WP_DB_PREFIX \
                    --dbcharset=$WP_DB_CHARSET \
                    --path=/var/www/wordpress

    # Instala o WordPress
    wp core install --url="$WP_URL" \
                    --title="$WP_TITLE" \
                    --admin_user="$WP_ADMIN" \
                    --admin_password="$WP_ADMIN_PASSWORD" \
                    --admin_email="$WP_ADMIN_EMAIL" \
                    --allow-root

    # Instala e ativa o tema
    wp theme install twentynineteen --activate --allow-root
    echo "WordPress installed"
else
    echo "WordPress already installed"
fi

# Ajusta permissões
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

# Inicia o PHP-FPM
php-fpm82 -F
