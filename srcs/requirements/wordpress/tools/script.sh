#!/bin/bash

cat > /var/www/html/wp-config.php << EOF
<?php
define('DB_NAME', '$DB_NAME');
define('DB_USER', '$DB_USER');
define('DB_PASSWORD', '$DB_PASSWORD');
define('DB_HOST', '$DB_HOST');
EOF

#-F makes it. run un foreground
exec php-fpm -F