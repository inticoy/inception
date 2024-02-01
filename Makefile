all: up

up:
	docker compose --file ./srcs/docker-compose.yml up -d --build 

down:
	docker compose --file ./srcs/docker-compose.yml down

start:
	docker compose --file ./srcs/docker-compose.yml start

stop:
	docker compose --file ./srcs/docker-compose.yml stop

clean:
	docker compose -f ./srcs/docker-compose.yml down
	docker volume rm mariadbv wordpress