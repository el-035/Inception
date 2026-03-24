FROM debian

#install mariadb
RUN apt-get update && apt-get install -y mariadb-server mariadb-client

EXPOSE 3306

#data directory for volume
RUN mkdir -p /var/lib/mysql

COPY ./tools/script.sh script.sh
RUN chmod +x /script.sh

CMD ["/script.sh"]

CMD ["mysql_safe"]