.DEFAULT_GOAL:=help

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

DOCKER_LABEL        += --label org.label-schema.schema-version="$(IMAGE):$(VERSION)"
DOCKER_LABEL        += --label org.label-schema.url="$(GIT_REPOS_URL)"
DOCKER_LABEL        += --label org.label-schema.usage="C++ deloppement environment"
DOCKER_LABEL        += --label org.label-schema.vcs-ref="$(SHORT_SHA1)"
DOCKER_LABEL        += --label org.label-schema.vcs-url="$(GIT_REPOS_URL)"
DOCKER_LABEL        += --label org.label-schema.vcs-type="Git  SCM"
DOCKER_LABEL        += --label org.label-schema.vendor="Acme Systems Engineering"
DOCKER_LABEL        += --label org.label-schema.documentation=$(GIT_REPOS_URL)
DOCKER_LABEL        += --label org.label-schema.version=$(VERSION)
DOCKER_LABEL        += --label org.label-schema.docker.cmd="make dds-base run"
DOCKER_LABEL        += --label org.label-schema.docker.dockerfile=$(DOCKER_FILE)
DOCKER_LABEL        += --label org.label-schema.release-date=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ")

# FQIN - fully qualified image name
# Builder - Contains all the build artifacts and depedencies
# Runtime - Contains only the minimum necessary artifacts to run the microservice
BUILDER_FQIN        := $(CONTAINER_IMAGE)
RUNTIME_FQIN        := $(IMAGE):$(VERSION)

.PHONY: image-info
image-info: ## Display docker image information.
	$(call purple, "  # $@ -> from $< ... $(BUILDER_FQIN)")
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
	$(call purple, "  # $@ -> from $< ... $(BUILDER_FQIN)")
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


.PHONY: build
build: build-image ## Build Docker images base.
	# @echo "+ $@"

.PHONY: build-image
build-image:
	# $(call purple, "  # $@ -> from $< ... $(BUILDER_FQIN)")
	@echo "$(BLUE) Build of $(BUILDER_FQIN) from $(BASE_IMAGE) $(NO_COLOR) "
	# @$(DOCKER) build $(DOCKER_LABEL) --no-cache --force-rm $(BUILD_ARGS)  -t $(BUILDER_FQIN):$(VERSION) --file Dockerfile  .
	@$(DOCKER) build $(DOCKER_LABEL) $(BUILD_ARGS)  -t $(BUILDER_FQIN):$(VERSION) --file Dockerfile  .
	@echo
	@echo "Build finished."

.PHONY: push
 push: push-image ## Push docker image to DTR.

.PHONY: push-image
push-image: build-image
	@echo "$(BLUE) Apply tag $(MAJOR).$(MINOR).$(PATCH) on $(BUILDER_FQIN)  $(NO_COLOR) "
	#@$(DOCKER) tag $(BUILDER_FQIN):$(MAJOR).$(MINOR).$(PATCH) $(BUILDER_FQIN):latest
	#@$(DOCKER) tag $(BUILDER_FQIN):$(MAJOR).$(MINOR).$(PATCH) $(BUILDER_FQIN):latest
	@echo
	@echo "$(BLUE) Pushing  $(BUILDER_FQIN):$(MAJOR).$(MINOR).$(PATCH) to $(DOCKER_TRUSTED_REGISTRY) $(NO_COLOR) "
	#@$(DOCKER) push $(BUILDER_FQIN):$(MAJOR).$(MINOR).$(PATCH)
	#@$(DOCKER) push $(BUILDER_FQIN):latest
	@echo "$(MAJOR).$(MINOR).$(PATCH)" > $(VERSIONFILE)
	@echo "Image pushed to DTR"

.PHONY: run
run : run-image ## Run docker image.

.PHONY: run-image
run-image : build-image
	$(call purple, "  # $@ -> from $< ... Running tag  $(BUILDER_FQIN)")
	# $(DOCKER) run --rm \
        # --volume ${HOME}/.conan:/home/developer/.conan \
        # --volume ${HOME}/.ssh:/home/developer/.ssh \
        # --volume ${HOME}/.vim:/home/developer/.vim \
        # --volume ${HOME}/.vimrc:/home/developer/.vimrc \
        # --volume $(PWD)/src/main/resources/dotfiles/.bashrc:/home/developer/.bashrc \
        # --volume ${HOME}/.m2:/home/developer/.m2 \
        # --volume $(PWD):/home/developer/workspace \
        # --tty --interactive $(BUILDER_FQIN):$(VERSION)

#docker run --rm -it -v $(pwd):/home/java -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY <Image Name> eclipse
#docker run --rm -it -v $(pwd):/home/java -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY <Image Name> netbeans
#docker run --rm -ti -e HOST_PERMS="$(id -u):$(id -g)" --volume "${HOME}/.conan:/home/happyman/.conan" --volume ${HOME}/.vimrc:/home/happyman/.vim --volume ${HOME}/.vimrc:/home/happyman/.vimrc --volume ${HOME}/.bashrc:/home/happyman/.bashrc  <dtr>/ns/dds:latest --volume "$PWD:/home/happyman/workspace"
# Run the docker
# docker run --rm -ti --name="$CITBX_DOCKER_PREFIX-build" --hostname="$CITBX_DOCKER_PREFIX-build" \
#     -e CI=true -e GITLAB_CI=true -v /var/run/docker.sock:/var/run/docker.sock \
#     "${CITBX_DOCKER_RUN_ARGS[@]}" --label "$CITBX_DOCKER_PREFIX" "${CITBX_JOB_DOCKER_RUN_ARGS[@]}" \
#     -e DOCKER_RUN_EXTRA_ARGS="$(bashopts_get_def bashopts_extra_args)" "${bashopts_extra_args[@]}" \
#     $CITBX_DOCKER_IMAGE "${CITBX_PRE_COMMANDS[@]}" $CITBX_JOB_SHELL -c "$CITBX_COMMANDS" \
#     || exit $?

.PHONY: help
help: ## Display this help and exits.
	@echo "$@ ->"
	@echo '---------------$(CURDIR)------------------'
	@echo '+----------------------------------------------------------------------+'
	@echo '|                        Available Commands                            |'
	@echo '+----------------------------------------------------------------------+'
	@echo
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf " \033[36m%-20s\033[0m  %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ""
	@echo


define purple
endef

define purples
	@tput setaf 5
	@echo " "
	@echo $1
	@echo " "
	@tput sgr0
endef