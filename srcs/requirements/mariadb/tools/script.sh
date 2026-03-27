#!/bin/bash

#first start database in the background, to configure, then close it and open it again in the foregruond so that docker container keeps running
#once mysqld_safe is executed it takes control and would not run the rest of the script

set -e

# start mariadb in background
echo "Starting temporary server"
mysqld_safe --user=mysql &

# wait until mariadb is ready
while ! mysqladmin ping --silent; do
	sleep 1
done

# create db and user if database doesnt already exist
if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
	echo "Creating database"
	mysql -u root -p"$DB_ROOT_PASS" -e "CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;"
	mysql -u root -p"$DB_ROOT_PASS" -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
	mysql -u root -p"$DB_ROOT_PASS" -e "GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'%';"
	mysql -u root -p"$DB_ROOT_PASS" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';"
	mysql -u root -p"$DB_ROOT_PASS" -e "FLUSH PRIVILEGES;"
else
	echo "Database already exists"
fi

# stop temporary server
echo "Closing temporary server"
mysqladmin -u root -p"$DB_ROOT_PASS" shutdown


# run mariadb in foreground
echo "Running MariaDB"
exec /usr/sbin/mariadbd --user=mysql
