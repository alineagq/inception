
SRC_DIR = srcs

all: up

up:
	@docker-compose -f $(SRC_DIR)/docker-compose.yml up --build -d

down:
	@docker-compose -f $(SRC_DIR)/docker-compose.yml down

clean:
	@docker system prune -af
	@docker volume prune -f

fclean: down clean

re: fclean all
