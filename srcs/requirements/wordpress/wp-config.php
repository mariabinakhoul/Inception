<?php
/* ************************************************************************** */
/*                                WordPress                                   */
/* ************************************************************************** */

/* Database settings */
define('DB_NAME', getenv('MYSQL_DATABASE'));
define('DB_USER', getenv('MYSQL_USER'));
define('DB_PASSWORD', getenv('MYSQL_PASSWORD'));
define('DB_HOST', getenv('WORDPRESS_DB_HOST'));
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

/* Authentication Unique Keys and Salts */
define('AUTH_KEY',         'inception_auth_key');
define('SECURE_AUTH_KEY',  'inception_secure_auth_key');
define('LOGGED_IN_KEY',    'inception_logged_in_key');
define('NONCE_KEY',        'inception_nonce_key');
define('AUTH_SALT',        'inception_auth_salt');
define('SECURE_AUTH_SALT', 'inception_secure_auth_salt');
define('LOGGED_IN_SALT',   'inception_logged_in_salt');
define('NONCE_SALT',       'inception_nonce_salt');

/* WordPress Database Table prefix */
$table_prefix = 'wp_';

/* Debugging mode (KEEP FALSE for Inception) */
define('WP_DEBUG', false);

/* Absolute path to the WordPress directory */
if (!defined('ABSPATH'))
    define('ABSPATH', dirname(__FILE__) . '/');

/* Sets up WordPress vars and included files */
require_once ABSPATH . 'wp-settings.php';
