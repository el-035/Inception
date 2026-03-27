FROM debian:12

#install mariadb
RUN apt-get update && apt-get upgrade && apt-get install -y mariadb-server
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/lib/apt/mysql/*

EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

#data directory for volume
RUN mkdir -p /var/lib/mysql
RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql


COPY ./tools/script.sh /
RUN chmod +x /script.sh

CMD ["/script.sh"]