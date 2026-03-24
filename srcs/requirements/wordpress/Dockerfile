FROM debian
#wordpress is basically a PHP-FPM container

RUN apt-get update && apt-get install -y php php-fpm php-mysql wget tar

RUN mkdir -p /var/www/html

#download wordpress, extract it and move it inside of var/www/html
RUN wget https://wordpress.org/latest.tar.gz && \
	tar -xzf latest.tar.gz && \
	mv wordpress/* /var/www/html/ && \
	rm -rf wordpress latest.tar.gz

EXPOSE 9000

COPY ./tools/script.sh script.sh
RUN chmod +x /script.sh

CMD ["/script.sh"]

#-F makes it run un foreground
#CMD ["php-fpm", "-F"]