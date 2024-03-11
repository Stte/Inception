FROM debian:bullseye

WORKDIR /

RUN apt-get update && apt-get -y upgrade && \
	apt-get -y install mariadb-server

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh

EXPOSE 3306

CMD ["setup.sh"]
