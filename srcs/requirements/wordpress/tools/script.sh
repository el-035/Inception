#!/bin/bash
set -e

cd /var/www/html

sleep 3

#download wordpress
if [ ! -f wp-load.php ]; then
	echo "Downloading wordpress"
	wp core download --allow-root
else
	echo "Wordpress already downloaded"
fi

rm -f /var/www/html/wp-config.php
# create wp-config
if [ ! -f wp-config.php ]; then
	echo "creating wp-config.php"
	wp config create --allow-root \
		--path=/var/www/html --dbname="$DB_NAME" \
		--dbuser="$DB_USER" --dbpass="$DB_PASSWORD" \
		--dbhost="$DB_HOST"
else
	echo "wp-config.php already created"
fi

#install wordpress
if ! wp core is-installed --allow-root; then
	echo "Installing WordPress"
	wp core install --allow-root --url="https://$DOMAIN_NAME" \
		--title="$WP_TITLE" --admin_user="$WP_ADMIN" \
		--admin_password="$WP_ADMIN_PASSWORD" \
		--admin_email="$WP_ADMIN_EMAIL" --skip-email
else
	echo "Wordpress already installed"
fi

# create admin if missing
if ! wp user get "$WP_ADMIN" --allow-root > /dev/null 2>&1; then
	echo "Creating admin user"
	wp user create --allow-root "$WP_ADMIN" "$WP_ADMIN_EMAIL" \
		--role=administrator \
		--user_pass="$WP_ADMIN_PASSWORD"
fi

# create normal user if missing
if ! wp user get "$WP_USER" --allow-root > /dev/null 2>&1; then
	echo "Creating normal user"
	wp user create --allow-root "$WP_USER" "$WP_USER_EMAIL" \
		--user_pass="$WP_USER_PASSWORD"
fi

#-F makes it run un forground
echo "Running WordPress"
exec /usr/sbin/php-fpm8.2 -F