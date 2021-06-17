.DEFAULT_GOAL := help

include makester/makefiles/makester.mk
include makester/makefiles/python-venv.mk
include makester/makefiles/compose.mk
include makester/makefiles/docker.mk

init: clear-env makester-requirements

backoff:
	@$(PYTHON) makester/scripts/backoff -d "Zeppelin web UI" -p 18888 localhost
	@$(PYTHON) makester/scripts/backoff -d "HiveServer2" -p 10000 localhost
	@$(PYTHON) makester/scripts/backoff -d "Web UI for HiveServer2" -p 10002 localhost

local-build-up: compose-up backoff
	@./hive-init.sh

local-build-down: compose-down

yarn-apps:
	@$(DOCKER) exec -ti hive\
 bash -c "/opt/hadoop/bin/yarn application -list -appStates ALL"

check-yarn-app-id:
	$(call check_defined, YARN_APPLICATION_ID)
yarn-app-log: check-yarn-app-id
	@$(DOCKER) exec -ti hive\
 bash -c "/opt/hadoop/bin/yarn logs -log_files stdout -applicationId $(YARN_APPLICATION_ID)"

help: makester-help python-venv-help compose-help
	@echo "(Makefile)\n\
  init                 Build the local virtual environment\n\
  local-build-up:      Create local ACRTA Case Study infrastructure and intialisation\n\
  local-build-down:    Destroy local ACRTA Case Study infrastructure\n\
  yarn-apps            List all YARN application IDs\n\
  yarn-app-log         Dump log for YARN application ID defined by \"YARN_APPLICATION_ID\"\n"
