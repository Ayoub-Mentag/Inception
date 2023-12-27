FROM debian:buster

RUN apt update && apt install mariadb-server -y

COPY ./conf/mariadb.conf /etc/mysql/mariadb.conf.d/

COPY ./tools/script.sh /

CMD ["./script.sh"]