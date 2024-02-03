VOL_PATH = /home/gyoon/data/

all: up

re: clean all

up:
	mkdir -p $(VOL_PATH)wp
	mkdir -p $(VOL_PATH)db
	docker compose --file ./srcs/docker-compose.yml up -d

down:
	docker compose --file ./srcs/docker-compose.yml down

start:
	docker compose --file ./srcs/docker-compose.yml start

stop:
	docker compose --file ./srcs/docker-compose.yml stop

clean:
	docker compose -f ./srcs/docker-compose.yml down
	docker volume rm -f wp db
	rm -rf $(VOL_PATH)db
	rm -rf $(VOL_PATH)wp

