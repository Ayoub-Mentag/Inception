#!/bin/bash


sed -i 's/^listen = .*/listen = wordpress:9000/' /etc/php/7.4/fpm/pool.d/www.conf

# sleep 20

apt install -y iputils-ping
RET=1
until [ ${RET} -eq 0 ]; do
    sleep 1
    echo "waiting for MariaDB to start ..."
    ping -c 1 mariadb;
    RET=$?
done

cd /var/www/html

# Download WordPress
wp core download --allow-root


# Configure WordPress
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/amentagdb/" wp-config.php
sed -i "s/username_here/amentag/" wp-config.php
sed -i "s/password_here/Normal/" wp-config.php
sed -i "s/localhost/mariadb/" wp-config.php

#install wp core
wp core install --url="amentag.42.fr" --title="$TITLE" --admin_user="$ADMIN_NAME" --admin_password="$ADMIN_PASS" --admin_email="$ADMIN_MAIL" --allow-root --path="/var/www/html"

# Add Normal User
wp user create "$WP_USER" "$WP_MAIL" --role="$WP_ROLE" --user_pass="$WP_PASS" --allow-root --path="/var/www/html"


# Starting the PHP FastCGI
/usr/sbin/php-fpm7.4 -F
