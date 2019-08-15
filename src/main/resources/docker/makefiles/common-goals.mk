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
    CONTAINER_IMAGE ?= $(IMAGE)-image-deploy
else
    DOCKER_LABEL    += --label org.label-schema.is-production="no"
    DOCKER_LABEL    += --label org.label-schema.is-beta="yes"
    CONTAINER_IMAGE ?= $(IMAGE)-dev
endif
DOCKER_LABEL        += --label org.label-schema.url="$(GIT_REPOS_URL)"
DOCKER_LABEL        += --label org.label-schema.vcs-ref="$(SHORT_SHA1)"
DOCKER_LABEL        += --label org.label-schema.vcs-url="$(GIT_REPOS_URL)"
DOCKER_LABEL        += --label org.label-schema.vcs-type="Git  SCM"
DOCKER_LABEL        += --label org.label-schema.vendor="Acme Systems Engineering"
DOCKER_LABEL        += --label org.label-schema.documentation=$(GIT_REPOS_URL)
DOCKER_LABEL        += --label org.label-schema.release-date=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ")


 .PHONY: dtr-login
dtr-login: ## loging to DTR
	# echo "${DTR_PASSWORD}" | docker login -u "${DTR_NAMESPACE}" --password-stdin ${DOCKER_TRUSTED_REGISTRY}

.PHONY: dtr-logout
dtr-logout: ## Logout from DTR
	# $(Q)docker logout ${DOCKER_TRUSTED_REGISTRY} || true

.PHONY: build
build: build-image dtr-login push dtr-logout ## Build and deploy Docker images base.

.PHONY: build-image
build-image:
	$(Q)echo "$(CLR_CY_AN) Build of $(BUILDER_FQIN) from $(BASE_IMAGE) $(SH_DEFAULT)"
	# $(Q)$(DOCKER) build $(DOCKER_LABEL) $(BUILD_ARGS)  -t $(BUILDER_FQIN):$(VERSION) --file Dockerfile .
	$(Q)echo "Build of $(BUILDER_FQIN):$(VERSION) finished."

.PHONY: push
 push: push-image ## Push docker image to DTR.

.PHONY: push-image
push-image:
	$(Q)echo "$(BLUE) Apply tag $(MAJOR).$(MINOR).$(PATCH) on $(BUILDER_FQIN)  $(SH_DEFAULT)"
	# $(Q)$(DOCKER) tag $(BUILDER_FQIN):$(VERSION) $(BUILDER_FQIN):latest
	$(Q)echo
	$(Q)echo "$(SH_BLUE) Pushing $(BUILDER_FQIN):[$(VERSION)|latest] to $(DOCKER_TRUSTED_REGISTRY)$(SH_DEFAULT)"
	# $(Q)$(DOCKER) push $(BUILDER_FQIN):$(VERSION)
	# $(Q)$(DOCKER) push $(BUILDER_FQIN):latest
	# $(Q)echo "$(MAJOR).$(MINOR).$(PATCH)" > $(VERSIONFILE)
	$(Q)echo "$(SH_GREEN) Images $(BUILDER_FQIN):[$(VERSION)|latest] pushed to DTR$(SH_DEFAULT)"

.PHONY: run
run : run-image ## Run docker image.

.PHONY: run-image
run-image : build-image
	$(call purple, "  # $@ -> from $< ... Running tag  $(BUILDER_FQIN)")
	$(Q)$(DOCKER) run --rm \
        --name="dev-build" \
        --hostname="docker-dev-build" \
        --volume ${HOME}/.conan:/home/developer/.conan \
        --volume ${HOME}/.ssh:/home/developer/.ssh \
        --volume ${HOME}/.m2:/home/developer/.m2 \
        --volume $(CWD)/src/main/resources/dotfiles/.vim:/home/developer/.vim \
        --volume $(CWD)/src/main/resources/dotfiles/.vimrc:/home/developer/.vimrc \
        --volume $(CWD)/src/main/resources/dotfiles/.bashrc:/home/developer/.bashrc \
        --volume $(CWD):/home/developer/workspace \
        --volume /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix${DISPLAY}  \
        --tty --interactive $(BUILDER_FQIN):$(VERSION)  
        # || exit $?

.PHONY: versioninfo
versioninfo: ## Display informations about the image.
	$(Q)echo "Version file: $(VERSIONFILE)"
	$(Q)echo "Current version: $(VERSION)"
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

