include makester/makefiles/base.mk
include makester/makefiles/python-venv.mk
include makester/makefiles/compose.mk

init: makester-requirements

backoff:
	@$(PYTHON) makester/scripts/backoff -d "Zeppelin web UI" -p 18888 localhost
	@$(PYTHON) makester/scripts/backoff -d "HiveServer2" -p 10000 localhost
	@$(PYTHON) makester/scripts/backoff -d "Web UI for HiveServer2" -p 10002 localhost

local-build-up: compose-up backoff
	@./hive-init.sh

local-build-down: compose-down

help: base-help python-venv-help compose-help
	@echo "(Makefile)\n\
  init                 Build the local virtual environment\n\
  local-build-up:      Create local ACRTA Case Study infrastructure and intialisation\n\
  local-build-down:    Destroy local ACRTA Case Study infrastructure\n"

.PHONY: help
