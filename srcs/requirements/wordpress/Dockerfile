FROM debian:12
#wordpress is basically a PHP-FPM container

RUN apt-get update && apt-get install -y php php-fpm php-mysql php-mysqli wget tar

RUN mkdir -p /var/www/html

# Configure PHP-FPM to listen on  9000 instead of a Unix socket so NGINX in another container can connect to it
RUN sed -i 's|^listen = .*|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf

#download wordpress, extract it and move it inside of var/www/html
RUN wget https://wordpress.org/wordpress-6.9.4.tar.gz && \
	tar -xzf wordpress-6.9.4.tar.gz && \
	mv wordpress/* /var/www/html/ && \
	rm -rf wordpress 6.9.4.tar.gz

EXPOSE 9000

COPY ./tools/script.sh script.sh
RUN chmod +x /script.sh


CMD ["/script.sh"]

#-F makes it run un forground
CMD ["/usr/sbin/php-fpm8.2", "-F"]