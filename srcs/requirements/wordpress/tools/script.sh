#!/bin/bash

# Check if wp command exists, if not, install WP-CLI

apt install -y sudo 
apt install -y wget
apt install -y tar





# while ! mysqladmin -h"localhost" -P"3306" status; do
#     sleep 1
#     echo "waiting for MariaDB to start ..."
# done

sleep 20

echo "CONNECTED"

cd /var/www/html

# Download and extract WordPress
wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz

# Configure WordPress
cp wordpress/wp-config-sample.php wordpress/wp-config.php
sed -i "s/database_name_here/$DB_NAME/" wordpress/wp-config.php
sed -i "s/username_here/$USER_NAME/" wordpress/wp-config.php
sed -i "s/password_here/$USER_PASS/" wordpress/wp-config.php

if ! command -v wp &> /dev/null
then
    echo "Installing WP-CLI..."
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    sudo mv wp-cli.phar /usr/local/bin/wp
    echo "WP-CLI installed."
fi

# Install WordPress
wp core install --url="amentag.1337.ma" --title="$WEB_TITLE" --admin_user="$ADMIN_WP" --skip-email --admin_password="$ADMIN_PASS" --admin_email="$ADMIN_EMAIL" --path="./wordpress" --allow-root

# Add Admin User
wp user create "$ADMIN_USER" "$ADMIN_EMAIL" --role="administrator" --user_pass="$ADMIN_PASSWORD" --path="./wordpress" --allow-root

# Add Normal User
wp user create "$WP_USER" "$WP_EMAIL" --role="$WP_ROLE" --user_pass="$WP_PASS" --path="./wordpress" --allow-root

# Clean up (remove downloaded WordPress archive)
rm latest.tar.gz

# Starting the PHP FastCGI
/usr/sbin/php-fpm7.4 -F
