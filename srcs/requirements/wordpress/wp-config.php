<?php
/* ************************************************************************** */
/*                                WordPress                                   */
/* ************************************************************************** */

/* Database settings */
define('DB_NAME',     getenv('MYSQL_DATABASE'));
define('DB_USER',     getenv('MYSQL_USER'));
define('DB_PASSWORD', getenv('MYSQL_PASSWORD'));
define('DB_HOST',     getenv('WORDPRESS_DB_HOST'));
define('DB_CHARSET',  'utf8');
define('DB_COLLATE',  '');

/* Authentication Unique Keys and Salts */
define('AUTH_KEY',         'k#9mX@2pL$vQ8nR!wT5yF&jH3bG6cZ0sDuKlMoNqPxWaYeIi');
define('SECURE_AUTH_KEY',  'p$7vR!3nK@9mZ#2wL&jT5yF8bG0cQ6sDuHlMoNqXaYeIiWP');
define('LOGGED_IN_KEY',    'n!2mK@8pR#7vZ$3wL&jT5yF9bG0cQ6sDuHlMoNqXaYeIiWP');
define('NONCE_KEY',        'v$3pK!9mR@8nZ#2wL&jT5yF7bG0cQ6sDuHlMoNqXaYeIiWP');
define('AUTH_SALT',        'R!8mK@3pZ#9vL$2wT&jF5yG7bH0cQ6sDuNlMoXqYaWeIiPn');
define('SECURE_AUTH_SALT', 'Z#9vK!8mR@3pL$2wT&jF5yG7bH0cQ6sDuNlMoXqYaWeIiPn');
define('LOGGED_IN_SALT',   'L$2pK!3mR@9vZ#8wT&jF5yG7bH0cQ6sDuNlMoXqYaWeIiPn');
define('NONCE_SALT',       'w&5mK!2pR@3vZ#9nT$jF8yG7bH0cQ6sDuNlMoXqYaWeIiPL');

/* WordPress Database Table prefix */
$table_prefix = 'wp_';

/* Debugging mode (KEEP FALSE for Inception) */
define('WP_DEBUG', false);

/* Absolute path to the WordPress directory */
if (!defined('ABSPATH'))
    define('ABSPATH', dirname(__FILE__) . '/');

/* Sets up WordPress vars and included files */
require_once ABSPATH . 'wp-settings.php';