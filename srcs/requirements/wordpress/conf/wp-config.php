<?php
// ** Database settings - You can get this info from your web host ** //
define( 'DB_NAME', getenv('WP_DB_NAME') ?: 'wordpress' );
define( 'DB_USER', getenv('WP_DB_USER') ?: 'wordpress' );
define( 'DB_PASSWORD', getenv('WP_DB_PASSWORD') ?: 'wordpress' );
define( 'DB_HOST', getenv('WP_DB_HOST') ?: 'mariadb:3306' );
define( 'DB_CHARSET', getenv('WP_DB_CHARSET') ?: 'utf8' );
define( 'DB_COLLATE', '' );

$table_prefix = getenv('WP_DB_PREFIX') ?: 'wp_';

// ** Authentication Unique Keys and Salts ** //
define('AUTH_KEY',         'put your unique phrase here');
define('SECURE_AUTH_KEY',  'put your unique phrase here');
define('LOGGED_IN_KEY',    'put your unique phrase here');
define('NONCE_KEY',        'put your unique phrase here');
define('AUTH_SALT',        'put your unique phrase here');
define('SECURE_AUTH_SALT', 'put your unique phrase here');
define('LOGGED_IN_SALT',   'put your unique phrase here');
define('NONCE_SALT',       'put your unique phrase here');

// ** WordPress URL settings ** //
define( 'WP_HOME', getenv('WP_URL') ?: 'http://aqueiroz.42.fr' );
define( 'WP_SITEURL', getenv('WP_URL') ?: 'http://aqueiroz.42.fr' );

// ** Debugging mode ** //
define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
