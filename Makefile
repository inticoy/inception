all: up

re: clean all

up:
	docker compose --file ./srcs/docker-compose.yml up  --build 

down:
	docker compose --file ./srcs/docker-compose.yml down

start:
	docker compose --file ./srcs/docker-compose.yml start

stop:
	docker compose --file ./srcs/docker-compose.yml stop

clean:
	docker compose -f ./srcs/docker-compose.yml down
	docker volume rm srcs_db_volume srcs_wp_volume
