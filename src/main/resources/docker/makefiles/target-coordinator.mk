# %W% %G% %U%
#        cfs-com/src/main/resources/docker/makefiles/target-coordinator.mk
#
#               Copyright (c) 2014-2018 A.H.L
#
#        Permission is hereby granted, free of charge, to any person obtaining
#        a copy of this software and associated documentation files (the
#        "Software"), to deal in the Software without restriction, including
#        without limitation the rights to use, copy, modify, merge, publish,
#        distribute, sublicense, and/or sell copies of the Software, and to
#        permit persons to whom the Software is furnished to do so, subject to
#        the following conditions:
#
#        The above copyright notice and this permission notice shall be
#        included in all copies or substantial portions of the Software.
#
#        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#        EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#        MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#        NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
#        LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
#        OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
#
COMMON_IMG_BUILD_OPTS += BASE_IMAGE=$(BASE_IMAGE)
COMMON_IMG_BUILD_OPTS += DOCKERFILE=$(DOCKER_FILE)
COMMON_IMG_BUILD_OPTS += PROXY_URL=$(PROXY_URL)
COMMON_IMG_BUILD_OPTS += CWD="${CWD}"

.PHONY: dind
dind: ## Docker + docker-compose for custom dind
	$(Q)$(MAKE) $(COMMON_IMG_BUILD_OPTS) -C src/main/resources/docker/dind/ ${GOAL}

.PHONY: dds-base
dds-base: ## Build common dev environment for OpenSPlice,FastRTPS,OpenDDS
	$(Q)$(MAKE) $(COMMON_IMG_BUILD_OPTS) -C src/main/resources/docker/$(ARCH)/common/ ${GOAL}

.PHONY: omg-opendds
omg-opendds: ## Build dev environment for OpenDDS
	$(Q)$(MAKE) $(COMMON_IMG_BUILD_OPTS) -C src/main/resources/docker/$(ARCH)/omg ${GOAL}

.PHONY: vortex-opensplice
vortex-opensplice: ## Builddev environment for Vortex OpenSPlice
	$(Q)$(MAKE) $(COMMON_IMG_BUILD_OPTS) -C src/main/resources/docker/$(ARCH)/adlinktech ${GOAL}

.PHONY: fast-rtps
fast-rtps: ## Build common dev environment FastRTPS
	$(Q)$(MAKE) $(COMMON_IMG_BUILD_OPTS) -C src/main/resources/docker/$(ARCH)/eprosima ${GOAL}

.PHONY: rti-connext-dds
rti-connext-dds: ## Build common dev environment for RealTime Innovation DDS
	$(Q)$(MAKE) $(COMMON_IMG_BUILD_OPTS) -C src/main/resources/docker/$(ARCH)/rti ${GOAL}

.PHONY: check
check: ## Check binaries prerequisities.
	$(Q)docker --version  > /dev/null  || true
	$(Q)helm  version > /dev/null  || true
	$(Q)kubectl version > /dev/null|| true
	$(Q)zip --version > /dev/null
	$(Q)unzip -v > /dev/null

.PHONY: git-status
git-status : ## Check for uncommited chqnges
	$(Q)test -n "$(GIT_STATUS)" && echo "$(WARN_COLOR)warning: you have uncommitted changes $(NO_COLOR)" || true

.PHONY: list list_all_containers list_volumes
list: list_all_containers list_volumes  ## List all containers and volumes."

list_all_containers: ## List all containers.
	@echo " $(BLUE)  Containers on system: $(COLOR_RESET)"
	$(Q)docker ps -a

list_volumes: ## List all volumes.
	$(Q)echo "$(BLUE)  Volumes on system:  $(COLOR_RESET)"
	$(Q)docker volume ls
	$(Q)echo "$(RED)  Dangling volumes (may be deleted via 'docker volume rm xxx'):  $(COLOR_RESET)"
	$(Q)docker volume ls -f dangling=true

.PHONY: show-info
show-info:
	$(Q)$(call blue, "  # $@ -> from $< ...")

.PHONY: help
help: ## Display this help and exits.
	@echo '---------------$(GIT_REPOS_URL) ------------------'
	@echo '+----------------------------------------------------------------------+'
	@echo '|                        Available Commands                            |'
	@echo '+----------------------------------------------------------------------+'
	@echo
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf " \033[36m%-20s\033[0m  %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ""
	@echo

.PHONY: notice
notice:
	$(Q)echo " "
	$(Q)echo "NOTICE "
	$(Q)echo "  this makefile is not used by the jenkinsfile                 "
	$(Q)echo "  it is intended only as a convenience for local development   "
	$(Q)echo "  please maintain consistency between this and the jenkinsfile "
	$(Q)echo " "
