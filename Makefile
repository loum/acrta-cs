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

local-build-up: local-build-down
	@SERVICE_NAME=$(SERVICE_NAME) \
      HASH=$(HASH) \
      $(DOCKER_COMPOSE) \
      up -d
	@$(PYTHON) scripts/backoff -p 10000
	@./hive-init.sh

local-build-down:
	@SERVICE_NAME=$(SERVICE_NAME) \
      HASH=$(HASH) \
      $(DOCKER_COMPOSE) \
      down

help: base-help python-venv-help
	@echo "(Makefile)\n\
  init                 Build the local virtual environment\n\
  local-build-up:      Create local Hive/Zeppelin infrastructure and setup\n\
  local-build-down:    Destroy local Hive/Zeppelin infrastructure\n\
  local-build-config:  Local pipeline docker-compose config\n\
	";


.PHONY: help
