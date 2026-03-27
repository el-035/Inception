DOCKER := docker compose
COMPOSE_FILE := ./srcs/docker-compose.yml


up:
	$(DOCKER) -f $(COMPOSE_FILE) up

build:
	$(DOCKER) -f $(COMPOSE_FILE) build

stop:
	$(DOCKER) -f $(COMPOSE_FILE) stop

down:
	$(DOCKER) -f $(COMPOSE_FILE) down -v