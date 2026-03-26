#!/bin/bash

#first start database in the background, to configure, then close it and open it again in the foregruond so that docker container keeps running
#once mysqld_safe is executed it takes control and would not run the rest of the script


#start database in the background
# service mysql start 

# echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" >> conf.sql
# echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';" >> conf.sql
# echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';" >> conf.sql
# echo "FLUSH PRIVILEGES;" >> conf.sql

# mysql < conf.sql

# #-e executes the command (no interactive shell)
# # mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
# # mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
# # mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';"
# # mysql -u root -e "FLUSH PRIVILEGES;"

# #echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" > conf.sql

# #close database
# mysqladmin -u root -p"$DB_ROOT_PASS" shutdown

# #run again
# exec mysqld_safe 

#!/bin/bash
set -e

# start mariadb in background
mysqld_safe &

# wait until mariadb is ready
while ! mysqladmin ping --silent; do
	sleep 1
done

# create db and user
mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;"
mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
mysql -u root -e "GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"

# stop temporary server
mysqladmin -u root shutdown

# run mariadb in foreground
exec mysqld_safe