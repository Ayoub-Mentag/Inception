#!/bin/bash

set -e  # Exit on error

# Start MariaDB in the background
mysqld_safe &

# Wait for MariaDB to be ready
while ! mysqladmin ping --silent; do
    sleep 1
    echo "Waiting for MariaDB to be ready..."
done

# Create SQL script file
SQL_SCRIPT="/tmp/file.sql"
echo "CREATE DATABASE IF NOT EXISTS $SQL_DATABASE;" > "$SQL_SCRIPT"
echo "CREATE USER 'root'@'%' IDENTIFIED BY '$SQL_ROOT_PASSWORD';" >> "$SQL_SCRIPT"
echo "CREATE USER IF NOT EXISTS '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD';" >> "$SQL_SCRIPT"
echo "GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD';" >> "$SQL_SCRIPT"
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' with grant option;" >> "$SQL_SCRIPT"
echo "FLUSH PRIVILEGES;" >> "$SQL_SCRIPT"

# Print the content of the SQL script for debugging
echo "SQL Script:"
cat "$SQL_SCRIPT"

# Execute the SQL script
echo "Executing SQL script..."
mysql -u root -p"$SQL_ROOT_PASSWORD" < "$SQL_SCRIPT"

# Shutdown MariaDB
echo "Shutting down MariaDB..."
mysqladmin -u root -p"$SQL_ROOT_PASSWORD" shutdown

# Clean up
rm "$SQL_SCRIPT"

# Start MariaDB again
echo "Starting MariaDB again..."
mysqld_safe
