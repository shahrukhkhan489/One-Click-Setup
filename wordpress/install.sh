#!/bin/bash

sudo yum install -y httpd php php-mysql php-gd wget mysql-server git

sudo service httpd start
sudo service mysqld start

iptables -F
sudo service iptables stop

sudo chkconfig httpd on
sudo chkconfig mysqld on
sudo chkconfig iptables off

wget http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz 

sudo cp -r ~/wordpress/* /var/www/html


cat > "/var/www/html/wp-config.php" <<EOF
<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'wordpress');

/** MySQL database username */
define('DB_USER', 'root');

/** MySQL database password */
define('DB_PASSWORD', '');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'C5lYeSQffVCQzk:.-</|XdLHgA&bPOT@UKV#,5&#[lU!u?!=yQ*qPh$PZ7Tewina');
define('SECURE_AUTH_KEY',  ';^-E]MU3Y(oxaQC*qa1?npCj,p-y{=K(l*D[Gkw#{tBkSYmT yZ(BH4qScUEX!V~');
define('LOGGED_IN_KEY',    'wzIRXBV2-96KkixGdz4$:Q}L{x#CBM7_wt}iuIKQT:{]J}Y<pz`a|;=mfs>{V&hQ');
define('NONCE_KEY',        '=h^Mi7q$x=6|HbgmUB;%CX@~I^aWvtfz&jeJzvGGHu<1T}sE%q,ul#q9~-1R-;OD');
define('AUTH_SALT',        '$Y9eut=ur@+PFUFuD}M@<2~ /3`x]Z#N89 .gF>F^S`~:!9HiQi/,-mLmsQha2.Y');
define('SECURE_AUTH_SALT', 'd]#4Q0nYV~FZb1^3U6^K6R@]?EK+,g]}gAgyqOshh@{R[_<tlaN2MW}<Bwlwd7uQ');
define('LOGGED_IN_SALT',   'Mt$1-z 3XT2_3fz=5JjH^#N;r!S{T@!6$f0T.6i`iVf([QHk6ynS*[=#3D+VivOl');
define('NONCE_SALT',       'x6J&I-k_L@{JzbboJ1`BpB+3Z0C:$s<~,F*m=g&j^9YEZ3%h]x]X=&]VQ:{^3q+`');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');

EOF





# mysql_secure_installation


#mysql -u root 
#CREATE DATABASE wordpress; 
#CREATE USER wordpressuser@localhost; 
#SET PASSWORD FOR wordpressuser@localhost= PASSWORD("password"); 
#GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost IDENTIFIED BY 'password'; 
#FLUSH PRIVILEGES; exit;"





#################BLUEPRINT###########################

git clone https://github.com/devstructure/blueprint.git
cd blueprint
git clone https://github.com/rcrowley/mustache.sh.git
git submodule update --init
make && sudo make install

git config --global user.email "shahrukhkhan489@gmail.com"
git config --global user.name "Shahrukh Khan"

history -f

cd bin
./blueprint create server_blueprint
