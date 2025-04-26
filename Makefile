all: setup build up

setup:
	@sudo echo "Setting hosts..."
	@sudo chmod a+w /etc/hosts
	@sudo cat /etc/hosts | grep aqueiroz.42.fr || echo "127.0.0.1 aqueiroz.42.fr" >> /etc/hosts
	@sudo mkdir -p /home/aqueiroz/inception/data/wordpress
	@sudo mkdir -p /home/aqueiroz/inception/data/mariadb

build:
	docker-compose -f srcs/docker-compose.yml build

up:
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -a
	docker volume prune

fclean: clean
	sudo rm -rf /home/aqueiroz/inception/data
	rm -f srcs/.env

re: fclean all

.PHONY: all up down clean re hard-re generate_env
