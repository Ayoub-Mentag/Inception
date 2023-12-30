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
sed -i "s/database_name_here/amentagdb/" wordpress/wp-config.php
sed -i "s/username_here/amentag/" wordpress/wp-config.php
sed -i "s/password_here/Normal/" wordpress/wp-config.php
sed -i "s/localhost/mariadb/" wordpress/wp-config.php
if ! command -v wp &> /dev/null
then
    echo "Installing WP-CLI..."
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    sudo mv wp-cli.phar /usr/local/bin/wp
    echo "WP-CLI installed."
fi

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
