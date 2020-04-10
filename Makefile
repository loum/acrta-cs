SERVICE_NAME = acrta-cs

include makester/makefiles/base.mk
include makester/makefiles/python-venv.mk

DOCKER := $(shell which docker 2>/dev/null)
COMPOSE_FILES = -f $(SERVICE_NAME)/docker-compose.yml

init: pip-requirements

local-build-config:
	@SERVICE_NAME=$(SERVICE_NAME) \
      HASH=$(HASH) \
      $(DOCKER_COMPOSE) \
      config

backoff:
	@$(PYTHON) makester/scripts/backoff -d "HiveServer2" -p 10000 localhost
	@$(PYTHON) makester/scripts/backoff -d "Web UI for HiveServer2" -p 10002 localhost

compose-up:
	@SERVICE_NAME=$(SERVICE_NAME) HASH=$(HASH) $(DOCKER_COMPOSE) up -d

local-build-up: local-build-down compose-up backoff
	@./hive-init.sh

local-build-down:
	@SERVICE_NAME=$(SERVICE_NAME) HASH=$(HASH) $(DOCKER_COMPOSE) down

beeline: backoff
	@$(DOCKER) exec -ti hive\
 bash -c "HADOOP_HOME=/opt/hadoop /opt/hive/bin/beeline -u jdbc:hive2://localhost:10000"

help: base-help python-venv-help
	@echo "(Makefile)\n\
  init                 Build the local virtual environment\n\
  local-build-up:      Create local Hive/Zeppelin infrastructure and setup\n\
  local-build-down:    Destroy local Hive/Zeppelin infrastructure\n\
  local-build-config:  Local pipeline docker-compose config\n\
	";


.PHONY: help
