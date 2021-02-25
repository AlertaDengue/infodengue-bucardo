#######################################################
## Automate container recreation for dengue database ##
#######################################################

#######################################################
## Automate container recreation for dengue database ##
#######################################################

include .env

# Docker specific
ENV_FILE := .env
COMPOSE_FILE := docker/docker-compose.yml
NETWORK := bucardo
DOCKER := PYTHON_VERSION=$(PYTHON_VERSION) docker-compose -p $(NETWORK) -f $(COMPOSE_FILE) --env-file $(PWD)/$(ENV_FILE)
DOCKER_UP := $(DOCKER) up
DOCKER_RUN := $(DOCKER) run --rm
DOCKER_BUILD := $(DOCKER) build
DOCKER_STOP := $(DOCKER) rm --force --stop
DOCKER_EXEC := $(DOCKER) exec
DOCKER_REMOVE := $(DOCKER) down --remove-orphans
SERVICES := manager

# Configure database in the container
build:
	$(DOCKER_BUILD)

start:
	$(DOCKER_UP) -d

exec: deploy
	$(DOCKER_EXEC) $(SERVICES) bash

stop:
	$(DOCKER_STOP)

clean:
	@find ./ -name '*.pyc' -exec rm -f {} \;
	@find ./ -name '*.pyo' -exec rm -f {} \;
	@find ./ -name '*~' -exec rm -f {} \;
	rm -rf .cache
	rm -rf build
	rm -rf dist
	rm -rf *.egg-info
