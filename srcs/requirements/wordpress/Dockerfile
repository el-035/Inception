FROM debian:12
#wordpress is basically a PHP-FPM container

RUN apt-get update && apt-get upgrade && apt-get install -y php php-fpm php-mysql php-mysqli curl  tar

RUN mkdir -p /var/www/html

# Configure PHP-FPM to listen on  9000 instead of a Unix socket so NGINX in another container can connect to it
RUN sed -i 's|^listen = .*|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf

#download wordpress, extract it and move it inside of var/www/html
RUN apt-get update && apt-get install -y curl \
 	&& curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
 	&& chmod +x wp-cli.phar \
 	&& mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000

COPY ./tools/script.sh /script.sh
RUN chmod +x /script.sh

CMD ["/script.sh"]
