#       cfs-com/src/main/resources/docker/makefiles/common-goals.mk
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

DOCKER_LABEL        += --label org.label-schema.maintainer=$(DTR_NAMESPACE)
DOCKER_LABEL        += --label org.label-schema.build-date=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
DOCKER_LABEL        += --label org.label-schema.license="Licence · Apache-2.0"
ifeq ($(GIT_BRANCH),master)
    DOCKER_LABEL    += --label org.label-schema.is-beta="no"
    DOCKER_LABEL    += --label org.label-schema.is-production="yes"
    CONTAINER_IMAGE ?= $(APP_BASE_IMAGE_NAME)-image-deploy
else
    DOCKER_LABEL    += --label org.label-schema.is-production="no"
    DOCKER_LABEL    += --label org.label-schema.is-beta="yes"
    CONTAINER_IMAGE ?= $(APP_BASE_IMAGE_NAME)-dev
endif
DOCKER_LABEL        += --label org.label-schema.url="$(GIT_REPOS_URL)"
DOCKER_LABEL        += --label org.label-schema.vcs-ref="$(SHORT_SHA1)"
DOCKER_LABEL        += --label org.label-schema.vcs-url="$(GIT_REPOS_URL)"
DOCKER_LABEL        += --label org.label-schema.vcs-type="Git  SCM"
DOCKER_LABEL        += --label org.label-schema.vendor="Acme Systems Engineering"
DOCKER_LABEL        += --label org.label-schema.documentation=$(GIT_REPOS_URL)
DOCKER_LABEL        += --label org.label-schema.release-date=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ")

BUILD_ARGS          = --build-arg MAKEFLAGS=$(DK_MKFALGS)
BUILD_ARGS          += --build-arg DDS_BASE_IMAGE=$(BASE_IMAGE)
BUILD_ARGS          += --build-arg ACCOUNT=$(DTR_NAMESPACE)

#TTY_LOG             ?= "2>&1 | tee ${MODULE}_build_output.log"
TTY_LOG             ?= "${MODULE}_build_output.log 2>&1"
ifneq ($(CI_RUNNER_TAGS),)
    TTY_LOG         := "/dev/null 2>&1"
endif

BUILD_ARGS          += --build-arg LOG_OUTPUT=$(TTY_LOG)
BUILD_ARGS          += --build-arg CI_DOMAIN="$(CI_RUNNER_TAGS)"

ifneq ($(DDS_DEV_IMAGE),)
    BUILD_ARGS      += --build-arg DDS_DEV_IMAGE=$(DDS_DEV_IMAGE)
else
    $(warning DDS_DEV_IMAGE env not defined! using defaul docker.io/doevelopper/cfs-com-common:latest)
endif

ifneq ($(PROXY_URL),)
    BUILD_ARGS      += --build-arg http_proxy=$(PROXY_URL)
    BUILD_ARGS      += --build-arg https_proxy=$(PROXY_URL)
    BUILD_ARGS      += --build-arg no_proxy="/var/run/docker.sock,localhost,127.0.0.1,localaddress,.localdomain.com,192.168.*"
else
    BUILD_ARGS      +=
endif

 .PHONY: dtr-login
dtr-login: ## loging to DTR
ifneq ($(CI_RUNNER_TAGS),)
	echo "${DTR_PASSWORD}" | docker login -u "${DTR_NAMESPACE}" --password-stdin ${DOCKER_TRUSTED_REGISTRY}
endif

.PHONY: dtr-logout
dtr-logout: ## Logout from DTR
ifneq ($(CI_RUNNER_TAGS),)
	$(Q)$(DOCKER) logout ${DOCKER_TRUSTED_REGISTRY} || true
endif

.PHONY: build
build: build-image dtr-login push dtr-logout ## Build and deploy Docker images base.

.PHONY: build-image
build-image:
	$(Q)echo "$(SH_CYAN) Build of $(BUILDER_FQIN) from $(BASE_IMAGE) $(SH_DEFAULT)"
	$(Q)$(DOCKER) build $(DOCKER_LABEL) $(BUILD_ARGS) --tag  $(BUILDER_FQIN):$(SEM_VERSION) --file ./Dockerfile . 2>&1 | tee $(GIT_ROOTDIR)/$(shell basename $(CURDIR))_build_output.log
	$(Q)echo "Build of $(BUILDER_FQIN):$(SEM_VERSION) finished."

.PHONY: push
 push: push-image ## Push docker image to DTR.

.PHONY: push-image
push-image:
	$(Q)echo "$(SH_BLUE) Apply tag [$(SEM_VERSION)|latest] on $(BUILDER_FQIN)  $(SH_DEFAULT)"
	$(Q)$(DOCKER) tag $(BUILDER_FQIN):$(SEM_VERSION) $(BUILDER_FQIN):latest
	$(Q)echo
ifneq ($(CI_RUNNER_TAGS),)
	$(Q)echo "$(SH_BLUE) Pushing $(BUILDER_FQIN):[$(SEM_VERSION)|latest] to $(DOCKER_TRUSTED_REGISTRY)$(SH_DEFAULT)"
	$(Q)$(DOCKER) push $(BUILDER_FQIN):$(SEM_VERSION)
	$(Q)$(DOCKER) push $(BUILDER_FQIN):latest
	# $(Q)echo "$(SEM_VERSION)" > $(VERSIONFILE)
	$(Q)echo "$(SH_GREEN) Images $(BUILDER_FQIN):[$(SEM_VERSION)|latest] pushed to DTR$(SH_DEFAULT)"
endif

.PHONY: run
run : run-image ## Run docker image.

.PHONY: run-image
run-image :
	$(call purple, "  # $@ -> from $< ... Running tag  $(BUILDER_FQIN)")
	$(Q)$(DOCKER) ${DK_RUN_STD_ARG}  --name="$(shell basename $(CURDIR))-$(RND_NS)-$(date +'%Y%m%d-%H%M%S')" --hostname="$(shell basename $(CURDIR))-$(RND_NS)" --tty --interactive $(BUILDER_FQIN):$(SEM_VERSION)

.PHONY: exec-in
exec-in :  ## Run a command inside a docker image.
	# || exit $?

.PHONY: versioninfo
versioninfo: ## Display informations about the image.
	$(Q)echo "Version file: $(VERSIONFILE)"
	$(Q)echo "Current version: $(SEM_VERSION)"
	$(Q)echo "(major: $(MAJOR), minor: $(MINOR), patch: $(PATCH))"
	$(Q)echo "Last tag: $(LAST_TAG)"
	$(Q)echo "Build: $(BUILD) (total number of commits)"
	$(Q)echo "next major version: $(NEXT_MAJOR_VERSION)"
	$(Q)echo "next minor version: $(NEXT_MINOR_VERSION)"
	$(Q)echo "next patch version: $(NEXT_PATCH_VERSION)"
	$(Q)echo "--------------"
	$(Q)echo "Previous version file '$(VERSIONFILE)' commit: $(PREVIOUS_VERSIONFILE_COMMIT)"
	$(Q)echo "Previous version **from** version file: '$(PREVIOUS_VERSION)'"

.PHONY: image-info
image-info: ## Display docker image information.
	$(Q)$(DOCKER) inspect --format='Description:  {{.Config.Labels.Description}}' $(BUILDER_FQIN)
	$(Q)$(DOCKER) inspect --format='Vendor:   {{.Config.Labels.Vendor}}' $(BUILDER_FQIN)
	$(Q)$(DOCKER) inspect --format='Authors:  {{.Author}}' $(BUILDER_FQIN)
	$(Q)$(DOCKER) inspect --format='Version:  {{.Config.Labels.Version}}' $(BUILDER_FQIN)
	$(Q)$(DOCKER) inspect --format='DockerVersion:    {{.DockerVersion}}' $(BUILDER_FQIN)
	$(Q)$(DOCKER) inspect --format='Architecture: {{.Architecture}}' $(BUILDER_FQIN)
	$(Q)$(DOCKER) inspect --format='OS:       {{.Os}}' $(BUILDER_FQIN)
	$(Q)$(DOCKER) inspect --format='Size:         {{.Size}} bytes' $(BUILDER_FQIN)
	$(Q)$(DOCKER) inspect --format='Container : {{.Config.Image}}' $(BUILDER_FQIN)
	$(Q)$(DOCKER) inspect --format='{{.}} ' $(BUILDER_FQIN)
	$(Q)$(DOCKER) inspect --format '{{.Repository}}:{{.Tag}}\t\t Built: {{.CreatedSince}}\t\tSize: {{.Size}}'
	$(Q)$(DOCKER) inspect --format='{{if ne 0.0 .State.ExitCode }}{{.Name}} {{.State.ExitCode}}{{ end }}' $(BUILDER_FQIN)
	$(Q)$(DOCKER) inspect --format='{{.LogPath}}' $(BUILDER_FQIN)

.PHONY: help
help: ## Display this help and exits.
	$(Q)echo "$@ ->"
	$(Q)echo '---------------$(CURDIR)------------------'
	$(Q)echo '+----------------------------------------------------------------------+'
	$(Q)echo '|                        Available Commands                            |'
	$(Q)echo '+----------------------------------------------------------------------+'
	$(Q)echo
	$(Q)awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf " \033[36m%-20s\033[0m  %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	$(Q)echo ""
	$(Q)echo

