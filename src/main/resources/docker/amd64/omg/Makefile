.DEFAULT_GOAL:=help

#        cfs-com/src/main/resources/docker/amd64/omg/Makefile
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

# Define colors
CLR_DEFAULT := $(shell echo '\033[00m')
CLR_RED     := $(shell echo '\033[31m')
CLR_GREEN   := $(shell echo '\033[32m')
CLR_YELLOW  := $(shell echo '\033[33m')
CLR_BLUE    := $(shell echo '\033[34m')
CLR_PURPLE  := $(shell echo '\033[35m')
CLR_CYAN    := $(shell echo '\033[36m')


VERSIONFILE         = VERSION_FILE
VERSION             = $(shell [ -f $(VERSIONFILE) ] && head $(VERSIONFILE) || echo "0.0.1")
PREVIOUS_VERSIONFILE_COMMIT = $(shell git log -1 --pretty=%h $(VERSIONFILE) 2>/dev/null )
PREVIOUS_VERSION    =  $(shell [ -n "$(PREVIOUS_VERSIONFILE_COMMIT)" ] && git show $(PREVIOUS_VERSIONFILE_COMMIT)^:$(CURDIR)$(VERSIONFILE) )

MAJOR               = $(shell echo $(VERSION) | sed "s/^\([0-9]*\).*/\1/")
MINOR               = $(shell echo $(VERSION) | sed "s/[0-9]*\.\([0-9]*\).*/\1/")
PATCH               = $(shell echo $(VERSION) | sed "s/[0-9]*\.[0-9]*\.\([0-9]*\).*/\1/")
STAGE               = $(PATCH:$(VERSION)=0)
BUILD               = $(shell git log --oneline | wc -l | sed -e "s/[ \t]*//g")
NEXT_MAJOR_VERSION  = $(shell expr $(MAJOR) + 1).0.0-b$(BUILD)
NEXT_MINOR_VERSION  = $(MAJOR).$(shell expr $(MINOR) + 1).0-b$(BUILD)
NEXT_PATCH_VERSION  = $(MAJOR).$(MINOR).$(shell expr $(PATCH) + 1)-b$(BUILD)

TOP_LEVEL_DIR       := $(shell git rev-parse --show-toplevel)
TARGETS             ?= linux/amd64 linux/arm64  windows/amd64
SHELL               = /usr/bin/env bash
DOCKER_SHELL        := /bin/sh
DOCKER              = docker
DOCKER_LABEL        := --label org.label-schema.maintainer=$(DTR_NAMESPACE)
DOCKER_LABEL        += --label org.label-schema.title="C++ Dev env"
DOCKER_LABEL        += --label org.label-schema.build-date=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
DOCKER_LABEL        += --label org.label-schema.description="Env for developping DDS c++ application"
DOCKER_LABEL        += --label org.label-schema.name=$(IMAGE)
DOCKER_LABEL        += --label org.label-schema.license="no"

ifeq ($(GIT_BRANCH),master)
    DOCKER_LABEL    += --label org.label-schema.is-beta="no"
    DOCKER_LABEL    += --label org.label-schema.is-production="yes"
    CONTAINER_IMAGE ?= $(IMAGE)-image-deploy
else
    DOCKER_LABEL    += --label org.label-schema.is-production="no"
    DOCKER_LABEL    += --label org.label-schema.is-beta="yes"
    CONTAINER_IMAGE ?= $(IMAGE)-dev
endif

ifneq ($(PROXY_URL),)
    BUILD_ARGS          =  --build-arg http_proxy=$(PROXY_URL)
    BUILD_ARGS          += --build-arg https_proxy=$(PROXY_URL)
    BUILD_ARGS          += --build-arg no_proxy="/var/run/docker.sock,localhost,127.0.0.1,localaddress,.localdomain.com,192.168.*,registry.gear.ge.com"
else
    BUILD_ARGS          =
endif

DOCKER_LABEL        += --label org.label-schema.schema-version="$(IMAGE):$(VERSION)"
DOCKER_LABEL        += --label org.label-schema.url="$(GIT_REPOS_URL)"
DOCKER_LABEL        += --label org.label-schema.usage="OpenDDS applications deloppement environment"
DOCKER_LABEL        += --label org.label-schema.vcs-ref="$(SHORT_SHA1)"
DOCKER_LABEL        += --label org.label-schema.vcs-url="$(GIT_REPOS_URL)"
DOCKER_LABEL        += --label org.label-schema.vcs-type="Git  SCM"
DOCKER_LABEL        += --label org.label-schema.vendor="Acme Systems Engineering"
DOCKER_LABEL        += --label org.label-schema.documentation=$(GIT_REPOS_URL)
DOCKER_LABEL        += --label org.label-schema.version=$(VERSION)
DOCKER_LABEL        += --label org.label-schema.docker.cmd="make $CONTAINER_IMAGE run"
DOCKER_LABEL        += --label org.label-schema.docker.dockerfile=$(DOCKER_FILE)
DOCKER_LABEL        += --label org.label-schema.release-date=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ")

# FQIN - fully qualified image name
# Builder - Contains all the build artifacts and depedencies
# Runtime - Contains only the minimum necessary artifacts to run the microservice
BUILDER_FQIN        := $(CONTAINER_IMAGE)
RUNTIME_FQIN        := $(IMAGE):$(VERSION)

.PHONY: image-info
image-info: ## Display docker image information.
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
	@echo "Version file: $(VERSIONFILE)"
	@echo "Current version: $(VERSION)"
	@echo "(major: $(MAJOR), minor: $(MINOR), patch: $(PATCH))"
	@echo "Last tag: $(LAST_TAG)"
	@echo "Build: $(BUILD) (total number of commits)"
	@echo "next major version: $(NEXT_MAJOR_VERSION)"
	@echo "next minor version: $(NEXT_MINOR_VERSION)"
	@echo "next patch version: $(NEXT_PATCH_VERSION)"
	@echo "--------------"
	@echo "Previous version file '$(VERSIONFILE)' commit: $(PREVIOUS_VERSIONFILE_COMMIT)"
	@echo "Previous version **from** version file: '$(PREVIOUS_VERSION)'"

.PHONY: dtr-login
dtr-login: ## loging to DTR
	echo "${DTR_PASSWORD}" | docker login -u "${DTR_NAMESPACE}" --password-stdin ${DOCKER_TRUSTED_REGISTRY}

.PHONY: dtr-logout
dtr-logout: ## Logout from DTR
	@docker logout ${DOCKER_TRUSTED_REGISTRY} || true

.PHONY: build
build: build-image  dtr-login  push dtr-logout ## Build and deploy Docker images base.

.PHONY: build-image
build-image:
	@echo "$(BLUE) Build of $(BUILDER_FQIN) from $(BASE_IMAGE) $(NO_COLOR) "
	# @$(DOCKER) build $(DOCKER_LABEL) --no-cache --force-rm $(BUILD_ARGS)  -t $(BUILDER_FQIN):$(VERSION) --file Dockerfile  .
	@$(DOCKER) build $(DOCKER_LABEL) $(BUILD_ARGS)  -t $(BUILDER_FQIN):$(VERSION) --file Dockerfile  .
	@echo
	@echo "Build finished."

.PHONY: push
 push: push-image ## Push docker image to DTR.

.PHONY: push-image
push-image:
	@echo "$(BLUE) Apply tag $(MAJOR).$(MINOR).$(PATCH) on $(BUILDER_FQIN)  $(NO_COLOR) "
	@$(DOCKER) tag $(BUILDER_FQIN):$(VERSION) $(BUILDER_FQIN):latest
	@echo
	@echo "$(BLUE) Pushing  $(BUILDER_FQIN):$(MAJOR).$(MINOR).$(PATCH) to $(DOCKER_TRUSTED_REGISTRY) $(NO_COLOR) "
	@$(DOCKER) push $(BUILDER_FQIN):$(VERSION)
	@$(DOCKER) push $(BUILDER_FQIN):latest
	@echo "$(MAJOR).$(MINOR).$(PATCH)" > $(VERSIONFILE)
	@echo "Image pushed to DTR"
