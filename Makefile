.DEFAULT_GOAL:=help
# %W% %G% %U%
#        cfs-com/Makefile
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

export PROJECT_NAME        ?= $(shell basename $(CURDIR))
export DTR_NAMESPACE       ?= doevelopper
#  jfrog.io - docker.io - registry.gitlab.com - artifactory.io
export DOCKER_TRUSTED_REGISTRY ?= docker.io
export ARCH                ?= amd64
export PLATFORM            =
export BASE_IMAGE          =
export GOAL                ?= build
export APP_BASE_IMAGE_NAME := ${DOCKER_TRUSTED_REGISTRY}/${DTR_NAMESPACE}/${PROJECT_NAME}

ifneq ($(DOCKER_TRUSTED_REGISTRY),)
    ifneq ($(ARCH),)
        BASE_IMAGE         := $(ARCH)/ubuntu:19.04
        ifeq ($(PLATFORM),RTI)
        	BASE_IMAGE     := $(ARCH)/ubuntu:18.04
        endif
    else
        $(error ERROR - unsupported value $(ARCH) for target arch!)
    endif
else
    $(error ERROR - DTR not defined)
endif

include $(shell pwd -P)/src/main/resources/docker/makefiles/common-variables.mk
include $(shell pwd -P)/src/main/resources/docker/makefiles/target-coordinator.mk

# from cli
# make DOCKER_TRUSTED_REGISTRY=docker.io DTR_NAMESPACE=doevelopper ARCH=amd64 GOAL=build PLATFORM=RTI  rti-connext-dds
# make DOCKER_TRUSTED_REGISTRY=docker.io DTR_NAMESPACE=doevelopper ARCH=amd64 GOAL=build omg-opendds

