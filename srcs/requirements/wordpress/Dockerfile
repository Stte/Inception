FROM debian:bullseye

WORKDIR /

RUN apt-get update && apt-get -y upgrade && apt-get -y install php7.4 php7.4-fpm php7.4-mysqli mariadb-client wget

RUN mkdir -p /run/php && mkdir -p /var/www/html

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

COPY ./tools/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh

EXPOSE 9000

ENTRYPOINT [ "setup.sh" ]
