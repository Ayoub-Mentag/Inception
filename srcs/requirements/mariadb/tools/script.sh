#!/bin/bash

# Start the MariaDB server
mysqld_safe &

# Wait for MariaDB to start (adjust the sleep duration based on your system)
while ! mysqladmin ping --silent; do
    sleep 1
    echo "Waiting for MySQL to be ready..."
done

# MySQL commands to create a database and user for WordPress
echo "CREATE DATABASE amentagdb;" > tmp/myfile.sql
echo "CREATE USER 'root'@'%' IDENTIFIED BY 'amentag1234';" >> tmp/myfile.sql
echo "CREATE USER 'amentag'@'%' IDENTIFIED BY '1234';" >> tmp/myfile.sql
echo "GRANT ALL PRIVILEGES ON *.* TO 'amentag'@'%';" >> tmp/myfile.sql
echo "FLUSH PRIVILEGES;" >> tmp/myfile.sql

cat /tmp/myfile.sql

mysql -u root < /tmp/myfile.sql

mysqladmin -u root shutdown

# Run the MariaDB server in the foreground (this keeps the container running)
mysqld_safe
