#!/bin/bash

#first start database in the background, to configure, then close it and open it again in the foregruond so that docker container keeps running
#once mysqld_safe is executed it takes control and would not run the rest of the script


#start database
service mysql start

#-e executes the command (no interactive shell)
mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';"
mysql -e "FLUSH PRIVILEGES;"

#close database
mysqladmin -u root shutdown

#run again
exec mysqld_safe