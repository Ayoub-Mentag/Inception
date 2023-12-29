FROM	debian:bullseye

RUN		apt update && apt upgrade 
RUN		apt install -y mariadb-server

COPY	./tools/script.sh /
COPY 	./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN		chmod +x script.sh

EXPOSE 3306

ENTRYPOINT [ "./script.sh" ]