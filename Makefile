
SRC_DIR = srcs

all: up

up:
	@docker compose -f $(SRC_DIR)/docker-compose.yml up --build -d

down:
	@docker compose -f $(SRC_DIR)/docker-compose.yml down

clean:
	@docker system prune -af
	@docker volume prune -f

hardclean: clean
	@rm -rf $(SRC_DIR)/db/ $(SRC_DIR)/web

fclean: down clean

re: fclean all

.PHONY: all up down clean hardclean fclean re