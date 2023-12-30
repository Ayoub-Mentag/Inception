all : up

up : 
	@mkdir -p /home/amentag/data/wordpress /home/amentag/data/mariadb
	@docker-compose -f ./srcs/docker-compose.yml up --build

down : 
	@docker-compose -f ./srcs/docker-compose.yml down

status : 
	@docker ps