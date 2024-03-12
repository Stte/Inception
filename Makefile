YML_PATH = srcs/docker-compose.yml
FILES_PATH = /home/tspoof/data

.PHONY: up down ps clean fclean prune re all reset info

all:
	@if [ ! -d "$(FILES_PATH)/mariadb" ]; then \
		mkdir -p $(FILES_PATH)/mariadb; \
	fi
	@if [ ! -d "$(FILES_PATH)/wordpress" ]; then \
		mkdir -p $(FILES_PATH)/wordpress; \
	fi
	docker compose -f $(YML_PATH) up -d

up:
	docker compose -f $(YML_PATH) up -d

down:
	docker compose -f $(YML_PATH) down

ps:
	docker compose -f $(YML_PATH) ps

clean:
	docker compose -f $(YML_PATH) down --rmi all -v

fclean: clean
	@if [ -d $(FILES_PATH) ]; then \
		sudo rm -rf $(FILES_PATH); \
	fi;

prune:
	docker system prune --all --force --volumes

reset:
	docker stop $(docker ps -a -q); docker rm $(docker ps -qa); \
	docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); \
	docker network rm $(docker network ls -q)

re: fclean all

info:
	@echo "==================== IMAGES ===================="
	@docker images
	@echo
	@echo "============================= CONTAINERS ============================="
	@docker ps -a
	@echo
	@echo "=============== NETWORKS ==============="
	@docker network ls
	@echo
	@echo "====== VOLUMES ======"
	@docker volume ls

rm_all:
	docker stop $$(docker ps -aq);
	docker rm $$(docker ps -qa);
	docker rmi -f $$(docker images -qa);
	docker volume rm $$(docker volume ls -q);
	# docker network rm $$(docker network ls -q);
