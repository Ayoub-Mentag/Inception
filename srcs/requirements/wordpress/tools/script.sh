#!/bin/sh

sleep 20

cd /var/www/html

sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /etc/php/7.4/fpm/pool.d/www.conf

if [ ! -e index.php ]; then
    wp core download --allow-root
fi

# wp core download  --allow-root
if [ ! -e wp-config.php ]; then
    echo "Accessing to DB ...[wordpress]" 
    wp config create --dbname="amentagdb" \
                     --dbuser="amentag" \
                     --dbpass="1234" \
                     --dbhost="mariadb" \
                     --allow-root \
                     --path="/var/www/html"
fi

wp core install --url=$DOMAIN_NAME \
				--title=$TITLE \
				--admin_user=$ADMIN_USER \
                --skip-email \
				--allow-root \
				--admin_password=$ADMIN_PASSWD \
				--admin_email=$ADMIN_EMAIL --path="/var/www/html"


/usr/sbin/php-fpm7.4 -F