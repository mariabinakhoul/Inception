NAME = inception

COMPOSE = docker compose -f srcs/docker-compose.yml

all: up

up:
	mkdir -p /home/maria/data/mariadb
	mkdir -p /home/maria/data/wordpress
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

start:
	$(COMPOSE) start

stop:
	$(COMPOSE) stop

restart:
	$(COMPOSE) restart

build:
	$(COMPOSE) build

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

clean:
	$(COMPOSE) down -v
	sudo rm -rf /home/maria/data/mariadb
	sudo rm -rf /home/maria/data/wordpress

fclean: clean
	docker system prune -af

re: fclean up

.PHONY: all up down start stop restart build logs ps clean fclean re
