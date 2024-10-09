all: setup up

setup:
	@sudo echo "Setting hosts..."
	@sudo chmod a+w /etc/hosts
	@sudo cat /etc/hosts | grep aqueiroz.42.fr || echo "127.0.0.1 aqueiroz.42.fr" >> /etc/hosts
	@sudo mkdir -p /home/fer/inception/data/wordpress
	@sudo mkdir -p /home/fer/inception/data/mariadb

up:
	docker compose -f srcs/docker-compose.yml up -d

down:
	docker compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -a
	docker volume prune -a
	sudo rm -rf /home/fer/inception/data

re: down up

hard-re: clean up

.PHONY: all up down clean re hard-re
