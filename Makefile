.DEFAULT_GOAL:=help
DATE              	:= $(shell date -u "+%b-%d-%Y")
SHA1              	:= $(shell git rev-parse HEAD)
CWD               	:= $(shell pwd -P)
SHORT_SHA1        	:= $(shell git rev-parse --short=5 HEAD)
GIT_STATUS        	:= $(shell git status --porcelain)
GIT_BRANCH        	:= $(shell git rev-parse --abbrev-ref HEAD)
GIT_BRANCH_STR    	:= $(shell git rev-parse --abbrev-ref HEAD | tr '/' '_')
GIT_REPO          	:= $(shell git config --local remote.origin.url | sed -e 's/.git//g' -e 's/^.*\.com[:/]//g' | tr '/' '_' 2> /dev/null)
GIT_REPOS_URL     	:= $(shell git config --get remote.origin.url)
CURRENT_BRANCH      := $(shell git rev-parse --abbrev-ref HEAD)
GIT_BRANCHES        := $(shell git for-each-ref --format='%(refname:short)' refs/heads/ | xargs echo)
GIT_REMOTES         := $(shell git remote | xargs echo )
GIT_ROOTDIR         := $(shell git rev-parse --show-toplevel)
GIT_DIRTY           := $(shell git diff --shortstat 2> /dev/null | tail -n1 )
LAST_TAG_COMMIT     := $(shell git rev-list --tags --max-count=1)
# LAST_TAG            := $(shell git describe --tags $(LAST_TAG_COMMIT) )
PROJECT_NAME        := $(shell basename $(CURDIR))

DTR_NAMESPACE      	?= doelopper
#  jfrog.io - docker.io - registry.gitlab.com - artifactory.io
DOCKER_TRUSTED_REGISTRY ?= docker.io
ARCH                ?= amd64
PLATFORM            :=
BASE_IMAGE          =
IMAGE               =
GOAL			    := build

ifneq ($(DOCKER_TRUSTED_REGISTRY),)
    ifneq ($(ARCH),)
        BASE_IMAGE := $(ARCH)/ubuntu:18.10
        DOCKERFILE := src/main/resources/docker/amd64/Dockerfile
        IMAGE := $(DOCKER_TRUSTED_REGISTRY)/${DTR_NAMESPACE}/${PROJECT_NAME}
        ifeq ($(PLATFORM),RTI)
            BASE_IMAGE := $(ARCH)/ubuntu:16.04
            DOCKERFILE := src/main/resources/docker/amd64/rti/Dockerfile
            IMAGE := $(DOCKER_TRUSTED_REGISTRY)/${DTR_NAMESPACE}/${PROJECT_NAME}/rti-dds
        endif
    else
        $(error ERROR - unsupported value $(ARCH) for target arch!)
    endif
else
    $(error ERROR - DTR not defined)

endif

SHELL = $(MAKESHELL)
MAKESHELL = sh
# MAKEFLAGS = --no-builtin-rules
# MAKEFLAGS += --no-builtin-variables
# MAKEFLAGS += --no-print-directory
# MAKEFLAGS += --output-sync=target

COMMON_IMG_BUILD_OPTS = PROJECT_NAME=$(PROJECT_NAME)
COMMON_IMG_BUILD_OPTS += DTR_NAMESPACE=$(DTR_NAMESPACE)
COMMON_IMG_BUILD_OPTS += DOCKER_TRUSTED_REGISTRY=$(DOCKER_TRUSTED_REGISTRY)
COMMON_IMG_BUILD_OPTS += ARCH=$(ARCH)
COMMON_IMG_BUILD_OPTS += PLATFORM=
COMMON_IMG_BUILD_OPTS += BASE_IMAGE=$(BASE_IMAGE)
# COMMON_IMG_BUILD_OPTS += DOCKERFILE=$(DOCKERFILE)
COMMON_IMG_BUILD_OPTS += IMAGE=$(IMAGE)
COMMON_IMG_BUILD_OPTS += GIT_BRANCH=$(GIT_BRANCH)
COMMON_IMG_BUILD_OPTS += GIT_REPOS_URL=$(GIT_REPOS_URL)
COMMON_IMG_BUILD_OPTS += SHORT_SHA1=$(SHORT_SHA1)

.PHONY: dind
dind: ## Docker + docker-compose for DIND 
	@echo "$@ -> from $<"
	@$(MAKE) $(COMMON_IMG_BUILD_OPTS) -C src/main/resources/docker/dind/ ${GOAL}

.PHONY: dds-base
dds-base: ## Build common dev environment for OpenSPlice,FastRTPS,OpenDDS
	@$(MAKE) $(COMMON_IMG_BUILD_OPTS) -C src/main/resources/docker/amd64/ng-dev-base/ ${GOAL}

.PHONY: opendds
opendds: dds-base ## Build dev environment for OpenDDS
	@echo "$@ -> from $< ..."
	@$(MAKE) $(COMMON_IMG_BUILD_OPTS) -C src/main/resources/docker/amd64/omg ${GOAL}

.PHONY: opensplice
opensplice: dds-base ## Builddev environment for Vortex OpenSPlice
	@echo "$@ -> from $< ..."
	@$(MAKE) $(COMMON_IMG_BUILD_OPTS) -C src/main/resources/docker/amd64/adlinktech ${GOAL}

.PHONY: rtps
rtps: dds-base ## Build common dev environment FastRTPS
	@echo "$@ -> from $< ..."
	@$(MAKE) $(COMMON_IMG_BUILD_OPTS) -C src/main/resources/docker/amd64/eprosima ${GOAL}

.PHONY: rti-dds-base
rti-dds-base: ## Build common dev environment for RealTime Innovation DDS
	@echo "$@ -> from $< ..."
	@$(MAKE) $(COMMON_IMG_BUILD_OPTS) -C src/main/resources/docker/amd64/rti ${GOAL}

.PHONY: check
check: ## Check binaries prerequisities.
	@docker --version  > /dev/null  || true
	@helm  version > /dev/null  || true
	@kubectl version > /dev/null|| true
	@zip --version > /dev/null
	@unzip -v > /dev/null

.PHONY: git-status
git-status : ## Check for uncommited chqnges
	@test -n "$(GIT_STATUS)" && echo "$(WARN_COLOR)warning: you have uncommitted changes $(NO_COLOR)" || true

.PHONY: list list_all_containers list_volumes
list: list_all_containers list_volumes  ## List all containers and volumes."

list_all_containers: ## List all containers.
	@echo " $(BLUE)  Containers on system: $(COLOR_RESET)"
	@docker ps -a

list_volumes: ## List all volumes.
	@echo "$(BLUE)  Volumes on system:  $(COLOR_RESET)"
	@docker volume ls
	@echo "$(RED)  Dangling volumes (may be deleted via 'docker volume rm xxx'):  $(COLOR_RESET)"
	@docker volume ls -f dangling=true

.PHONY: show-info
show-info:
#	$(call blue, "  # $@ -> ...")
	$(call blue, "  # $@ -> from $< ...")

.PHONY: help
help: ## Display this help and exits.
	$(call blue, "  # $@ -> from $< ...")
	@echo '---------------$(GIT_REPOS_URL) ------------------'
	@echo '+----------------------------------------------------------------------+'
	@echo '|                        Available Commands                            |'
	@echo '+----------------------------------------------------------------------+'
	@echo
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf " \033[36m%-20s\033[0m  %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ""
	@echo

# FUNCTIONS
define blue
	# @tput setaf 4
	@echo " "
	@echo $1
	@echo " "
	# @tput sgr0
endef