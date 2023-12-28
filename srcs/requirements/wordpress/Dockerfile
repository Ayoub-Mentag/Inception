FROM debian:bullseye

RUN apt update -y
RUN apt install -y php7.4-fpm\
    php7.4-mysql\
    mariadb-client\
    curl

RUN mkdir -p /var/www/html
RUN chmod 777 /var/www/html

RUN mkdir -p /run/php/

# RUN sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|g" /etc/php/7.4/fpm/pool.d/www.conf
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/script.sh .
RUN chmod +x script.sh

EXPOSE 9000

ENTRYPOINT [ "./script.sh" ]