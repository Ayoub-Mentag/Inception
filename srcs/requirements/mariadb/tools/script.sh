#!/bin/bash

# Start the MariaDB server
mysqld_safe &

# Wait for MariaDB to start
while ! mysqladmin -h"localhost" -P"3306" status; do
    sleep 1
    echo "waiting for MariaDB to start ..."
done

echo "CREATE DATABASE $DB_NAME;
CREATE USER '$ROOT_NAME'@'%' IDENTIFIED BY '$ROOT_PASS';
CREATE USER '$USER_NAME'@'%' IDENTIFIED BY '$USER_PASS';
GRANT ALL PRIVILEGES ON *.* TO '$ROOT_NAME'@'%';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$USER_NAME'@'%';
FLUSH PRIVILEGES;" > $SQL_SCRIPT

mysql -u $ROOT_NAME < $SQL_SCRIPT

mysqladmin -u $ROOT_NAME shutdown

# Run the MariaDB server in the foreground (this keeps the container running)
mysqld_safe