
# sleep 20

# cd /var/www/html

# sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /etc/php/7.4/fpm/pool.d/www.conf

# if [ ! -e index.php ]; then
#     wp core download --allow-root
# fi

# # wp core download  --allow-root
# if [ ! -e wp-config.php ]; then
#     echo "Accessing to DB ...[wordpress]"
#     wp config create --dbname=$DB_NAME \
#                      --dbuser=$USER_NAME \
#                      --dbpass=$USER_PASS \
#                      --dbhost=$DB_HOST \
#                      --allow-root \
#                      --path="/var/www/html"
# fi

# wp core install --url=$DMN \
# 				--title=$WEB_TITLE \
# 				--admin_user=$ADMIN_WP \
#                 --skip-email \
# 				--allow-root \
# 				--admin_password=$ADMIN_PASS \
# 				--admin_email=$ADMIN_EMAIL --path="/var/www/html"


# wp user create $WP_USER $WP_EMAIL --allow-root\
#         --role=$WP_ROLE \
#         --user_pass=$WP_PASS \
#         --path="/var/www/html"

# /usr/sbin/php-fpm7.4 -F

