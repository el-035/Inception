FROM debian:12
#wordpress is basically a PHP-FPM container

RUN apt-get update && apt-get install -y php php-fpm php-mysql wget tar

RUN mkdir -p /var/www/html

#download wordpress, extract it and move it inside of var/www/html
RUN wget https://wordpress.org/6.9.4.tar.gz && \
	tar -xzf 6.9.4.tar.gz && \
	mv wordpress/* /var/www/html/ && \
	rm -rf wordpress 6.9.4.tar.gz

EXPOSE 9000

COPY ./tools/script.sh script.sh
RUN chmod +x /script.sh

CMD ["/script.sh"]

#-F makes it run un foreground
#CMD ["php-fpm", "-F"]