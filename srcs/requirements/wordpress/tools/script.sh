#!/bin/bash

cat > /var/www/html/wp-config.php << EOF
<?php
define('DB_NAME', '$WP_DB_NAME');
define('DB_USER', '$WP_DB_USER');
define('DB_PASSWORD', '$WP_DB_PASSWORD');
define('DB_HOST', '$WP_DB_HOST');
EOF

#-F makes it run un foreground
exec php-fpm -F