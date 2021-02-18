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

deploy:
	$(DOCKER_UP) -d

exec-manager: deploy
	$(DOCKER_EXEC) $(SERVICES) bash

recreate_container:
	make remove_image_bucardo_db
	make deploy

remove_image_bucardo_db:
	$(DOCKER_STOP)
	$(DOCKER_REMOVE)


clean:
	@find ./ -name '*.pyc' -exec rm -f {} \;
	@find ./ -name '*.pyo' -exec rm -f {} \;
	@find ./ -name '*~' -exec rm -f {} \;
	rm -rf .cache
	rm -rf build
	rm -rf dist
	rm -rf *.egg-info

include $(ENVFILE)
export

# Docker specific
COMPOSE_FILE := docker/docker-compose.yml
NETWORK := bucardo
DOCKER := PYTHON_VERSION=$(PYTHON_VERSION) docker-compose -p $(NETWORK) -f $(COMPOSE_FILE) --env-file .env
DOCKER_UP := $(DOCKER) up
DOCKER_RUN := $(DOCKER) run --rm
DOCKER_BUILD := $(DOCKER) build
DOCKER_STOP := $(DOCKER) rm --force --stop
DOCKER_EXEC := $(DOCKER) exec
DOCKER_NETWORK_REMOVE := $(DOCKER) down --remove-orphans
DOCKER_IMAGES := $(docker images -q 'docker_bucardo_db' | uniq)
DOCKER_REMOVE := docker rmi --force $(DOCKER_IMAGES) ###
SERVICES := manager


# Configure database in the container
build:
	$(DOCKER_BUILD)

deploy:
	$(DOCKER_UP) -d

exec: deploy
	$(DOCKER_EXEC) $(SERVICES) bash

remove_container:
	$(DOCKER_STOP)
	#$(DOCKER_REMOVE)

clean:
	@find ./ -name '*.pyc' -exec rm -f {} \;
	@find ./ -name '*.pyo' -exec rm -f {} \;
	@find ./ -name '*~' -exec rm -f {} \;
	rm -rf .cache
	rm -rf build
	rm -rf dist
	rm -rf *.egg-info
