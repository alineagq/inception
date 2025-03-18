all: setup up

setup: generate_env
	@sudo echo "Setting hosts..."
	@sudo chmod a+w /etc/hosts
	@sudo cat /etc/hosts | grep aqueiroz.42.fr || echo "127.0.0.1 aqueiroz.42.fr" >> /etc/hosts
	@sudo mkdir -p /home/aqueiroz/inception/data/wordpress
	@sudo mkdir -p /home/aqueiroz/inception/data/mariadb
	@sudo mkdir -p /home/aqueiroz/inception/data/vault

generate_env:
	@echo "Generating .env file..."
	@read -p "Enter WordPress database name (default: wordpress): " wp_db_name; \
	wp_db_name=$${wp_db_name:-wordpress}; \
	read -p "Enter WordPress database user (default: wordpress): " wp_db_user; \
	wp_db_user=$${wp_db_user:-wordpress}; \
	read -s -p "Enter WordPress database password: " wp_db_password; \
	echo ""; \
	read -p "Enter WordPress admin username (default: admin): " wp_admin; \
	wp_admin=$${wp_admin:-admin}; \
	read -s -p "Enter WordPress admin password: " wp_admin_password; \
	echo ""; \
	read -p "Enter WordPress admin email (default: admin@aqueiroz.42.fr): " wp_admin_email; \
	wp_admin_email=$${wp_admin_email:-admin@aqueiroz.42.fr}; \
	read -p "Enter MySQL root user (default: root): " mysql_root_user; \
	mysql_root_user=$${mysql_root_user:-root}; \
	read -s -p "Enter MySQL root password: " mysql_root_password; \
	echo ""; \
	read -p "Enter MySQL user (default: wordpress): " mysql_user; \
	mysql_user=$${mysql_user:-wordpress}; \
	read -s -p "Enter MySQL password: " mysql_password; \
	echo ""; \
	read -p "Enter MySQL database (default: wordpress): " mysql_database; \
	mysql_database=$${mysql_database:-wordpress}; \
	echo "DOMAIN_NAME=aqueiroz.42.fr" > srcs/.env; \
	echo "WP_DB_NAME=$$wp_db_name" >> srcs/.env; \
	echo "WP_DB_USER=$$wp_db_user" >> srcs/.env; \
	echo "WP_DB_PASSWORD=$$wp_db_password" >> srcs/.env; \
	echo "WP_DB_HOST=mariadb:3306" >> srcs/.env; \
	echo "WP_DB_PREFIX=wp_" >> srcs/.env; \
	echo "WP_DB_CHARSET=utf8" >> srcs/.env; \
	echo "WP_ADMIN=$$wp_admin" >> srcs/.env; \
	echo "WP_ADMIN_PASSWORD=$$wp_admin_password" >> srcs/.env; \
	echo "WP_ADMIN_EMAIL=$$wp_admin_email" >> srcs/.env; \
	echo "WP_URL=http://aqueiroz.42.fr" >> srcs/.env; \
	echo "WP_TITLE=aqueiroz.42.fr" >> srcs/.env; \
	echo "WP_ADMIN_URL=http://aqueiroz.42.fr/marvin" >> srcs/.env; \
	echo "MYSQL_ROOT_USER=$$mysql_root_user" >> srcs/.env; \
	echo "MYSQL_ROOT_PASSWORD=$$mysql_root_password" >> srcs/.env; \
	echo "MYSQL_USER=$$mysql_user" >> srcs/.env; \
	echo "MYSQL_PASSWORD=$$mysql_password" >> srcs/.env; \
	echo "MYSQL_DATABASE=$$mysql_database" >> srcs/.env; \
	chmod 600 srcs/.env; \
	echo "✅ .env file generated"

build:
	docker-compose -f srcs/docker-compose.yml build

up: build
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -a
	docker volume prune -a
	sudo rm -rf /home/aqueiroz/inception/data
	rm -f srcs/.env

re: down up

hard-re: clean setup up

.PHONY: all up down clean re hard-re generate_env
