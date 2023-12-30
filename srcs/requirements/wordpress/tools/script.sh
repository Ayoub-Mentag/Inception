#!/bin/bash

# Check if wp command exists, if not, install WP-CLI

apt install -y sudo 
apt install -y wget
apt install -y tar


sed -i 's/^listen = .*/listen = wordpress:9000/' /etc/php/7.4/fpm/pool.d/www.conf

# while ! mysqladmin -h"localhost" -P"3306" status; do
#     sleep 1
#     echo "waiting for MariaDB to start ..."
# done

sleep 20

echo "CONNECTED"listen

cd /var/www/html

# # Download and extract WordPress
# wget https://wordpress.org/latest.tar.gz
# tar -xzvf latest.tar.gz


# # Download WordPress
wp core download --allow-root


# Configure WordPress
cp wordpress/wp-config-sample.php wordpress/wp-config.php
sed -i "s/database_name_here/amentagdb/" wordpress/wp-config.php
sed -i "s/username_here/amentag/" wordpress/wp-config.php
sed -i "s/password_here/Normal/" wordpress/wp-config.php
sed -i "s/localhost/mariadb/" wordpress/wp-config.php

#install wp core [REMOVE --skip emain]
wp core install --url="amentag.1337.ma" --title="WebTitle" --admin_user="Ayoub" --admin_password="Secret" --admin_email="admin@example.com" --skip-email --path="./wordpress" --allow-root

# Add Normal User
wp user create "normal-user" "normal@example.com" --role="author" --user_pass="Normal" --path="./wordpress" --allow-root

# Clean up (remove downloaded WordPress archive)
rm latest.tar.gz

chmod 777 wordpress/*
chown -R www-data:www-data /var/www/html/wordpress

# Starting the PHP FastCGI
/usr/sbin/php-fpm7.4 -F
