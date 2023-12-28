FROM	debian:bullseye

RUN		apt update && apt upgrade 

RUN		apt install -y mariadb-server

COPY	./tools/script.sh /tmp/script.sh

COPY 	./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN		chmod +x /tmp/script.sh

EXPOSE 3306

ENTRYPOINT [ "./tmp/script.sh" ]