.DEFAULT_GOAL:=help

VERSIONFILE       	= VERSION_FILE
VERSION           	= $(shell [ -f $(VERSIONFILE) ] && head $(VERSIONFILE) || echo "0.0.1")
PREVIOUS_VERSIONFILE_COMMIT = $(shell git log -1 --pretty=%h $(VERSIONFILE) 2>/dev/null )
PREVIOUS_VERSION  	=  $(shell [ -n "$(PREVIOUS_VERSIONFILE_COMMIT)" ] && git show $(PREVIOUS_VERSIONFILE_COMMIT)^:$(CURDIR)$(VERSIONFILE) )

MAJOR         		= $(shell echo $(VERSION) | sed "s/^\([0-9]*\).*/\1/")
MINOR         		= $(shell echo $(VERSION) | sed "s/[0-9]*\.\([0-9]*\).*/\1/")
PATCH     		    = $(shell echo $(VERSION) | sed "s/[0-9]*\.[0-9]*\.\([0-9]*\).*/\1/")
STAGE 				= $(PATCH:$(VERSION)=0)
BUILD             	= $(shell git log --oneline | wc -l | sed -e "s/[ \t]*//g")
NEXT_MAJOR_VERSION 	= $(shell expr $(MAJOR) + 1).0.0-b$(BUILD)
NEXT_MINOR_VERSION 	= $(MAJOR).$(shell expr $(MINOR) + 1).0-b$(BUILD)
NEXT_PATCH_VERSION 	= $(MAJOR).$(MINOR).$(shell expr $(PATCH) + 1)-b$(BUILD)

DATE              	:= $(shell date -u "+%b-%d-%Y")
SHA1              	:= $(shell git rev-parse HEAD)
CWD               	:= $(shell pwd -P)
SHORT_SHA1        	:= $(shell git rev-parse --short=5 HEAD)
GIT_STATUS        	:= $(shell git status --porcelain)
GIT_BRANCH        	:= $(shell git rev-parse --abbrev-ref HEAD)
GIT_BRANCH_STR    	:= $(shell git rev-parse --abbrev-ref HEAD | tr '/' '_')
GIT_REPO          	:= $(shell git config --local remote.origin.url | sed -e 's/.git//g' -e 's/^.*\.com[:/]//g' | tr '/' '_' 2> /dev/null)
GIT_REPOS_URL     	:= $(shell git config --get remote.origin.url)
COVERITY_STREAM   	:= $(GIT_REPO)_$(GIT_BRANCH)

DTR_NAMESPACE      	?= doelopper

#  docker.io - registry.gitlab.com artifactory
DOCKER_TRUSTED_REGISTRY ?= docker.io
ARCH                ?= amd64
PLATFORM            :=
BASE_IMAGE          =
IMAGE               =

ifneq ($(DOCKER_TRUSTED_REGISTRY),)
    ifneq ($(ARCH),)
        BASE_IMAGE := $(ARCH)/ubuntu:18.10
		DOCKERFILE := src/main/resources/docker/amd64/foss.Dockerfile
		IMAGE := $(DOCKER_TRUSTED_REGISTRY)/${DTR_NAMESPACE}/foss-dds
        ifeq ($(PLATFORM),RTI)
            BASE_IMAGE := $(ARCH)/ubuntu:16.04
			DOCKERFILE := src/main/resources/docker/amd64/rti/Dockerfile
			IMAGE := $(DOCKER_TRUSTED_REGISTRY)/${DTR_NAMESPACE}/rti-dds
        endif
    else
        $(error ERROR - unsupported value $(ARCH) for target arch!)
    endif
else
    $(error ERROR - DTR not defined)

endif

DEV_IMAGE           ?= $(IMAGE)-dev
PROD_IMAGE          ?= $(IMAGE)-image-deploy
                      # FQIN - fully qualified image name
                      # Builder - Contains all the build artifacts and depedencies
                      # Runtime - Contains only the minimum necessary artifacts to run the microservice
BUILDER_FQIN        := $(DEV_IMAGE)
RUNTIME_FQIN        := $(IMAGE):$(VERSION)
TARGETS             ?= linux/amd64 linux/arm64  windows/amd64
SHELL               = /usr/bin/env bash
DOCKER_SHELL        := /bin/sh
DOCKER              = docker
DOCKER_LABEL        := --label org.label-schema.maintainer=$(USER)
DOCKER_LABEL        += --label org.label-schema.build-date=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
DOCKER_LABEL        += --label org.label-schema.description="Env for developping RTI DDS c++ application"
DOCKER_LABEL        += --label org.label-schema.name=$(IMAGE)
DOCKER_LABEL        += --label org.label-schema.license="no"

ifeq ($(GIT_BRANCH),master)
	DOCKER_LABEL    += --label org.label-schema.is-beta="no"
    DOCKER_LABEL    += --label org.label-schema.is-production="yes"
else
    DOCKER_LABEL    += --label org.label-schema.is-production="no"
	DOCKER_LABEL    += --label org.label-schema.is-beta="yes"
endif

DOCKER_LABEL        += --label org.label-schema.schema-version="$(IMAGE):$(VERSION)"
DOCKER_LABEL        += --label org.label-schema.url="$(GIT_REPOS_URL)"
DOCKER_LABEL        += --label org.label-schema.usage="C++ deloppement environment"
DOCKER_LABEL        += --label org.label-schema.vcs-ref="$(SHORT_SHA1)"
DOCKER_LABEL        += --label org.label-schema.vcs-url="$(GIT_REPOS_URL)"
DOCKER_LABEL        += --label org.label-schema.vcs-type="Git  SCM"
DOCKER_LABEL        += --label org.label-schema.vendor="Acme Systems Engineering"
DOCKER_LABEL        += --label org.label-schema.version=$(VERSION)
DOCKER_LABEL        += --label org.label-schema.docker.cmd="docker run -v ~/:..."
DOCKER_LABEL        += --label org.label-schema.release-date=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ")

.PHONY: help
help: ## Display this help and exits.
	@echo '-----------------------------------------------  $(GIT_REPOS_URL)'
	@echo
	@echo "    Please use \`make <target>' where <target> is one of : "
	@echo
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf " \033[36m%-20s\033[0m  %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ""
	@echo

.PHONY: git-status
git-status : ## Check for uncommited chqnges
	@test -n "$(GIT_STATUS)" && echo "$(WARN_COLOR)warning: you have uncommitted changes $(NO_COLOR)" || true

.PHONY: check
check: ## Check binaries prerequisities.
	docker --version  > /dev/null
	helm  version > /dev/null  || true
	kubectl version > /dev/null|| true
	zip --version > /dev/null
	unzip -v > /dev/null

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

.PHONY: image-info
image-info: ## Display docker image information.
	@echo "+ $@"
	@docker inspect --format='Description:  {{.Config.Labels.Description}}' $(BUILDER_FQIN)
	@docker inspect --format='Vendor:   {{.Config.Labels.Vendor}}' $(BUILDER_FQIN)
	@docker inspect --format='Authors:  {{.Author}}' $(BUILDER_FQIN)
	@docker inspect --format='Version:  {{.Config.Labels.Version}}' $(BUILDER_FQIN)
	@docker inspect --format='DockerVersion:    {{.DockerVersion}}' $(BUILDER_FQIN)
	@docker inspect --format='Architecture: {{.Architecture}}' $(BUILDER_FQIN)
	@docker inspect --format='OS:       {{.Os}}' $(BUILDER_FQIN)
	@docker inspect --format='Size:         {{.Size}} bytes' $(BUILDER_FQIN)
	@docker inspect --format='Container : {{.Config.Image}}' $(BUILDER_FQIN)
	@docker inspect --format='{{.}} ' $(BUILDER_FQIN)
	@docker inspect --format '{{.Repository}}:{{.Tag}}\t\t Built: {{.CreatedSince}}\t\tSize: {{.Size}}'
#	@docker inspect --format='{{if ne 0.0 .State.ExitCode }}{{.Name}} {{.State.ExitCode}}{{ end }}' $(BUILDER_FQIN)

.PHONY: versioninfo
versioninfo: ## Display informations about the image.
	@echo "+ $@"
	@echo "Version file: $(VERSIONFILE)"
	@echo "Current version: $(VERSION)"
	@echo "(major: $(MAJOR), minor: $(MINOR), patch: $(PATCH))"
	@echo "Last tag: $(LAST_TAG)"
	@echo "$(shell git rev-list $(LAST_TAG).. --count) commit(s) since last tag"
	@echo "Build: $(BUILD) (total number of commits)"
	@echo "next major version: $(NEXT_MAJOR_VERSION)"
	@echo "next minor version: $(NEXT_MINOR_VERSION)"
	@echo "next patch version: $(NEXT_PATCH_VERSION)"
	@echo "--------------"
	@echo "Previous version file '$(VERSIONFILE)' commit: $(PREVIOUS_VERSIONFILE_COMMIT)"
	@echo "Previous version **from** version file: '$(PREVIOUS_VERSION)'"


.PHONY: build
build: build-image ## Build Docker images base.
	@echo "+ $@"

.PHONY: build-image
build-image: git-status
	@echo "+ $@"
	@echo "$(BLUE) Build of $(BUILDER_FQIN) from $(BASE_IMAGE) $(NO_COLOR) "
	# $(DOCKER) build $(DOCKER_LABEL) --no-cache --force-rm $(BUILD_ARGS)  -t $(BUILDER_FQIN):$(VERSION) --file $(DOCKERFILE) .
	@echo
	@echo "Build finished."

.PHONY: push
 push: push-image ## Push docker image to DTR.

.PHONY: push-image
push-image: build-image
	@echo "+ $@"
	@echo "$(BLUE) Apply tag $(MAJOR).$(MINOR).$(PATCH) on $(BUILDER_FQIN)  $(NO_COLOR) "
	# $(DOCKER) tag $(BUILDER_FQIN):$(MAJOR).$(MINOR).$(PATCH) $(BUILDER_FQIN):latest
	# $(DOCKER) tag $(BUILDER_FQIN):$(MAJOR).$(MINOR).$(PATCH) $(BUILDER_FQIN):latest
	@echo
	@echo "$(BLUE) Pushing  $(BUILDER_FQIN):$(MAJOR).$(MINOR).$(PATCH) to $(DOCKER_TRUSTED_REGISTRY) $(NO_COLOR) "
	# $(DOCKER) push $(BUILDER_FQIN):$(MAJOR).$(MINOR).$(PATCH)
	# $(DOCKER) push $(BUILDER_FQIN):latest
	@echo "Image pushed to DTR"

.PHONY: run
run : run-image ## Run docker image.

.PHONY: run-image
run-image : build-image
	@echo "+ $@"
	@echo "$(BLUE) Running tag  $(BUILDER_FQIN)  $(NO_COLOR) : uses host's conan as package manager"
	$(DOCKER) run --rm \
    	--volume ${HOME}/.conan:/home/developer/.conan \
    	--volume ${HOME}/.ssh:/home/developer/.ssh \
		--volume ${HOME}/.vim:/home/developer/.vim \
    	--volume ${HOME}/.vimrc:/home/developer/.vimrc \
    	--volume $(PWD)/src/main/resources/dotfiles/.bashrc:/home/developer/.bashrc \
		--volume ${HOME}/.m2:/home/developer/.m2 \
    	--volume $(PWD):/home/developer/workspace \
    	--tty --interactive $(BUILDER_FQIN):$(VERSION)

#docker run --rm -it -v $(pwd):/home/java -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY <Image Name> eclipse
#docker run --rm -it -v $(pwd):/home/java -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY <Image Name> netbeans
#docker run --rm -ti -e HOST_PERMS="$(id -u):$(id -g)" --volume "${HOME}/.conan:/home/happyman/.conan" --volume ${HOME}/.vimrc:/home/happyman/.vim --volume ${HOME}/.vimrc:/home/happyman/.vimrc --volume ${HOME}/.bashrc:/home/happyman/.bashrc  <dtr>/ns/dds:latest --volume "$PWD:/home/happyman/workspace"




