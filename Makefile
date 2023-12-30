
build:
	docker-compose -f ./srcs/docker-compose.yml up --build

fclean :
	docker system prune -a
	docker volume prune --force
	rm -rf ~/wordpress/*
	rm -rf ~/wordpress/*