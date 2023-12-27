#!/bin/sh

cd /var/www/html

sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /etc/php/7.4/fpm/pool.d/www.conf

if [ ! -e index.php ]; then
    wp core download --allow-root
fi

# wp core download  --allow-root
if [ ! -e wp-config.php ]; then
    wp config create --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASSWORD --dbhost=$DB_HOST --allow-root --path="/var/www/html"
fi

wp core install --url=$DOMAIN_NAME --title=$TITLE --admin_user=$ADMIN_USER --skip-email --allow-root --admin_password=$ADMIN_PASSWD --admin_email=$ADMIN_EMAIL --path="/var/www/html"

/usr/sbin/php-fpm7.4 -F