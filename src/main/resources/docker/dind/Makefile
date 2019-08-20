.DEFAULT_GOAL:=help

#       cfs-com/src/main/resources/docker/dind/Makefile
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

CONTAINER_IMAGE      = ${APP_BASE_IMAGE_NAME}-$(shell basename $(CURDIR))

DOCKER_LABEL        := --label org.label-schema.title="Dind docker-compose make git"
DOCKER_LABEL        += --label org.label-schema.description="Docker in docker for running container usin CI"
DOCKER_LABEL        += --label org.label-schema.name=$(CONTAINER_IMAGE)
DOCKER_LABEL        += --label org.label-schema.schema-version="$(CONTAINER_IMAGE):$(SEM_VERSION)"
DOCKER_LABEL        += --label org.label-schema.version=$(SEM_VERSION)
DOCKER_LABEL        += --label org.label-schema.usage="Image used by gitlab-ci to build and run c++ app"
DOCKER_LABEL        += --label org.label-schema.docker.cmd="make $(shell basename $(CURDIR)) run"
DOCKER_LABEL        += --label org.label-schema.docker.dockerfile=$(DOCKER_FILE)

# FQIN - fully qualified image name
# Builder - Contains all the build artifacts and depedencies
# Runtime - Contains only the minimum necessary artifacts to run the microservice
BUILDER_FQIN        := $(CONTAINER_IMAGE)
RUNTIME_FQIN        := $(IMAGE):$(SEM_VERSION)

include $(CWD)/src/main/resources/docker/makefiles/common-goals.mk

