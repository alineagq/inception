#!/bin/sh

# Start WordPress

cd /var/www/wordpress

if [ ! -f /var/www/wordpress/wp-config.php ]; then
    echo "WordPress not installed yet"
    wp core config  --dbname=$WP_DB_NAME \
                    --dbuser=$WP_DB_USER \
                    --dbpass=$WP_DB_PASSWORD \
                    --dbhost=$WP_DB_HOST \
                    --allow-root \
                    --dbprefix=$WP_DB_PREFIX \
                    --dbcharset=$WP_DB_CHARSET \
                    --path=/var/www/wordpress

    wp core install --url="$WP_URL" \
                    --title="$WP_TITLE" \
                    --admin_user="$WP_ADMIN" \
                    --admin_password="$WP_ADMIN_PASSWORD" \
                    --admin_email="$WP_ADMIN_EMAIL" \
                    --allow-root

    wp theme install twentynineteen --activate --allow-root
    echo "WordPress installed"
    echo "$PWD"
else
    echo "WordPress already installed"
fi

php-fpm82 -F