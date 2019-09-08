# %W% %G% %U%
#        cfs-com/src/main/resources/docker/makefiles/common-variables.mk
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

ifeq ("$(origin V)", "command line")
    KBUILD_VERBOSE = $(V)
endif
ifndef KBUILD_VERBOSE
    KBUILD_VERBOSE = 0
endif

ifeq ($(KBUILD_VERBOSE),1)
    quiet =
    Q =
else
    quiet=quiet_
    Q = @
endif

ifneq ($(findstring s,$(filter-out --%,$(MAKEFLAGS))),)
    quiet=silent_
    tools_silent=s
endif

ifeq (0,${MAKELEVEL})
	whoami    := $(shell whoami)
	host-type := $(shell arch)
	# MAKE := ${MAKE} host-type=${host-type} whoami=${whoami}
endif

export quiet Q KBUILD_VERBOSE

export EMPTY               =
export SPACE               = $(EMPTY) $(EMPTY)
export MAKEDIR             = mkdir -p
export DOCKER              = docker
export RM                  = -rm -rf
export BIN                 := /usr/bin
export SHELL               = $(BIN)/env bash
export DOCKER_SHELL        := $(BIN)/sh
export CONFIG_SHEL         := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
	                           else if [ -x /bin/bash ]; then echo /bin/bash; \
	                           else echo sh; fi ; fi)

export PRINTF              := $(BIN)/printf
export DF                  := $(BIN)/df
export AWK                 := $(BIN)/awk
export PERL                := $(BIN)/perl
export PYTHON              := $(BIN)/python
export PYTHON2             := $(BIN)/python2
export PYTHON3             := $(BIN)/python3
export MSG                 := @bash -c '  $(PRINTF) $(YELLOW); echo "=> $$1";  $(PRINTF) $(NC)'
export UNAME_OS            := $(shell uname -s)
export HOST_RYPE           := $(shell arch)
export DATE                := $(shell date -u "+%b-%d-%Y")
export CWD                 := $(shell pwd -P)
export TARGETS             ?= linux/amd64 linux/arm64v8 windows/amd64

export VERSION             := $(shell git describe --tags --long --dirty --always | \
                                sed 's/v\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)-\?.*-\([0-9]*\)-\(.*\)/\1 \2 \3 \4 \5/g')
export SHA1                := $(shell git rev-parse HEAD)
export SHORT_SHA1          := $(shell git rev-parse --short=5 HEAD)
export GIT_STATUS          := $(shell git status --porcelain)
export GIT_BRANCH          := $(shell git rev-parse --abbrev-ref HEAD)
export GIT_BRANCH_STR      := $(shell git rev-parse --abbrev-ref HEAD | tr '/' '_')
export GIT_REPO            := $(shell git config --local remote.origin.url | \
                                sed -e 's/.git//g' -e 's/^.*\.com[:/]//g' | tr '/' '_' 2> /dev/null)
export GIT_REPOS_URL       := $(shell git config --get remote.origin.url)
export CURRENT_BRANCH      := $(shell git rev-parse --abbrev-ref HEAD)
export GIT_BRANCHES        := $(shell git for-each-ref --format='%(refname:short)' refs/heads/ | xargs echo)
export GIT_REMOTES         := $(shell git remote | xargs echo )
export GIT_ROOTDIR         := $(shell git rev-parse --show-toplevel)
export GIT_DIRTY           := $(shell git diff --shortstat 2> /dev/null | tail -n1 )
export LAST_TAG_COMMIT     := $(shell git rev-list --tags --max-count=1)
export GIT_COMMITS         := $(shell git log --oneline ${LAST_TAG}..HEAD | wc -l | tr -d ' ')
export GIT_REVISION        := $(shell git rev-parse --short=8 HEAD || echo unknown)
#export  LAST_TAG          := $(shell git describe --tags $(LAST_TAG_COMMIT) )
export GIT_LAST_TAG        := $(git log --first-parent --pretty="%d" | \
                                grep -E "tag: v[0-9]+\.[0-9]+\.[0-9]+(\)|,)" -o | \
                                grep "v[0-9]*\.[0-9]*\.[0-9]*" -o | head -n 1)

#export DK_MKFALGS          ="--no-print-directory -j$(shell nproc --all) --silent"
export DK_MKFALGS          ="--no-print-directory --silent"

ifneq ($(CI_VERSION),)
    export SEM_VERSION     := ${CI_VERSION}
else
    $(warning  VERSION not defined)
    export VERSIONFILE     = VERSION_FILE
    export SEM_VERSION     := $(shell [ -f $(VERSIONFILE) ] && head $(VERSIONFILE) || echo "0.0.1")
endif

export PREVIOUS_VERSIONFILE_COMMIT = $(shell git log -1 --pretty=%h $(VERSIONFILE) 2>/dev/null )
export PREVIOUS_VERSION    =  $(shell [ -n "$(PREVIOUS_VERSIONFILE_COMMIT)" ] && git show $(PREVIOUS_VERSIONFILE_COMMIT)^:$(CURDIR)$(VERSIONFILE) )

export MAJOR               = $(shell echo $(SEM_VERSION) | sed "s/^\([0-9]*\).*/\1/")
export MINOR               = $(shell echo $(SEM_VERSION) | sed "s/[0-9]*\.\([0-9]*\).*/\1/")
export PATCH               = $(shell echo $(SEM_VERSION) | sed "s/[0-9]*\.[0-9]*\.\([0-9]*\).*/\1/")
export STAGE               = $(PATCH:$(SEM_VERSION)=0)
export BUILD               = $(shell git log --oneline | wc -l | sed -e "s/[ \t]*//g")
export NEXT_MAJOR_VERSION  = $(shell expr $(MAJOR) + 1).0.0-b$(BUILD)
export NEXT_MINOR_VERSION  = $(MAJOR).$(shell expr $(MINOR) + 1).0-b$(BUILD)
export NEXT_PATCH_VERSION  = $(MAJOR).$(MINOR).$(shell expr $(PATCH) + 1)-b$(BUILD)

DK_RUN_STD_ARG      = run --rm
# DK_RUN_STD_ARG      += --memory=$(($(head -n 1 /proc/meminfo | awk '{print $2}') * 4 / 5))k
# DK_RUN_STD_ARG      += --cpus=$((`nproc` - 1)) ${}
DK_RUN_STD_ARG      += --log-opt max-size=50m
DK_RUN_STD_ARG      += --volume $(GIT_ROOTDIR)/src/main/resources/dotfiles/.vim:/home/${DTR_NAMESPACE}/.vim
DK_RUN_STD_ARG      += --volume $(GIT_ROOTDIR)/src/main/resources/dotfiles/.vimrc:/home/${DTR_NAMESPACE}/.vimrc
DK_RUN_STD_ARG      += --volume $(GIT_ROOTDIR)/src/main/resources/dotfiles/.bashrc:/home/${DTR_NAMESPACE}/.bashrc
DK_RUN_STD_ARG      += --volume $(GIT_ROOTDIR):/home/${DTR_NAMESPACE}/workspace
#DK_RUN_STD_ARG      += --volume /tmp/.X11-unix:/tmp/.X11-unix:rw
DK_RUN_STD_ARG      += --volume ${HOME}/.conan:/home/${DTR_NAMESPACE}/.conan
DK_RUN_STD_ARG      += --volume ${HOME}/.ssh:/home/${DTR_NAMESPACE}/.ssh
#DK_RUN_STD_ARG      += --volume ${HOME}/.Xauthority:/root/.Xauthority
DK_RUN_STD_ARG      += --volume ${HOME}/.m2:/home/${DTR_NAMESPACE}/.m2
#DK_RUN_STD_ARG      += --volume /etc/passwd:/etc/passwd:ro
#DK_RUN_STD_ARG      += --env DISPLAY=unix${DISPLAY}
DK_RUN_STD_ARG      += --env LANG=C.UTF-8
DK_RUN_STD_ARG      += --env LC_ALL=C.UTF-8
DK_RUN_STD_ARG      += --env DOCKER_USER=`id -un`
DK_RUN_STD_ARG      += --env DOCKER_USER_ID=`id -u`
DK_RUN_STD_ARG      += --env DOCKER_PASSWORD=`id -un`
DK_RUN_STD_ARG      += --env DOCKER_GROUP_ID=`id -g`

export DK_RUN_STD_ARG

export RND_NS       = $(shell cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
# Define colors for console output
# courtesy to https://deb.nodesource.com/setup_12.x
# IF_TERMINAL                := $(shell test -t 1)
# COLOR_SUPPORT              := $(shell which tput > /dev/null && tput colors)
# COLOR                      := $(shell test -n "${COLOR_SUPPORT}")
# COLOR_RANGG                := $(shell test ${COLOR_SUPPORT} -ge 8)

# ifeq ($(shell test -t 1),)

#     export SH_DEFAULT          := $(shell echo '\033[00m')
#     export SH_RED              := $(shell echo '\033[31m')
#     export SH_GREEN            := $(shell echo '\033[32m')
#     export SH_YELLOW           := $(shell echo '\033[33m')
#     export SH_BLUE             := $(shell echo '\033[34m')
#     export SH_PURPLE           := $(shell echo '\033[35m')
#     export SH_CYAN             := $(shell echo '\033[36m')

#     ifeq ($(shell test -n "${COLOR_SUPPORT}" && test ${COLOR_SUPPORT} -ge 8),)

#         export TERMCOLS           = $(shell tput cols)
#         export UNDERLINE          = $(shell tput smul)
#         export STANDOUT           = $(shell tput smso)
#         export BOLD               = $(shell tput bold)
#         export RESET              = $(shell tput sgr0)
#         export BLACK              = $(shell tput setaf 0)
#         export RED                = $(shell tput setaf 1)
#         export GREEN              = $(shell tput setaf 2)
#         export YELLOW             = $(shell tput setaf 3)
#         export BLUR               = $(shell tput setaf 4)
#         export MAGENTA            = $(shell tput setaf 5)
#         export CYAN               = $(shell tput setaf 6)
#         export WHITE              = $(shell tput setaf 7)
#     endif
# endif
