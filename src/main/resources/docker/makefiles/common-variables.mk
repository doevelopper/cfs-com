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

ifeq ($(KBUILD_VERBOSE),1)
  quiet =
  Q =
else
  quiet=quiet_
  Q = @
endif

# ifdef VERBOSE
#     Q :=
# else
#     Q := @
# endif

ifeq (0,${MAKELEVEL})
	whoami    := $(shell whoami)
	host-type := $(shell arch)
	# MAKE := ${MAKE} host-type=${host-type} whoami=${whoami}
endif

export EMPTY               =
export SPACE               = $(EMPTY) $(EMPTY)
export MAKEDIR             = mkdir -p
export DOCKER              = docker
export RM                  = -rm -rf
export BIN                 := /usr/bin
export SHELL               = $(BIN)/env bash
export DOCKER_SHELL        := $(BIN)/sh
export PRINTF              := $(BIN)/printf
export DF                  := $(BIN)/df
export AWK                 := $(BIN)/awk
export PERL                := $(BIN)/perl
export PYTHON              := $(BIN)/python
export PYTHON2             := $(BIN)/python2
export PYTHON3             := $(BIN)/python3
export DISPLAY             := @bash -c '  $(PRINTF) $(YELLOW); echo "=> $$1";  $(PRINTF) $(NC)'
export UNAME_OS            := $(shell uname -s)
export HOST_RYPE           := $(shell arch)
export DATE              	:= $(shell date -u "+%b-%d-%Y")
export CWD               	:= $(shell pwd -P)
export TARGETS             ?= linux/amd64 linux/arm64v8 windows/amd64
# Define colors for console output

export SH_DEFAULT          := $(shell echo '\033[00m')
export SH_RED              := $(shell echo '\033[31m')
export SH_GREEN            := $(shell echo '\033[32m')
export SH_YELLOW           := $(shell echo '\033[33m')
export SH_BLUE             := $(shell echo '\033[34m')
export SH_PURPLE           := $(shell echo '\033[35m')
export SH_CYAN             := $(shell echo '\033[36m')

export UNDERLINE           = $(shell tput smul)
export STANDOUT            = $(shell tput smso)
export BOLD                = $(shell tput bold)
export BLACK               = $(shell tput setaf 0)
export RED                 = $(shell tput setaf 1)
export GREEN               = $(shell tput setaf 2)
export YELLOW              = $(shell tput setaf 3)
export BLUR                = $(shell tput setaf 4)
export MAGENTA             = $(shell tput setaf 5)
export CYAN                = $(shell tput setaf 6)
export WHITE               = $(shell tput setaf 7)
export RESET               = $(shell tput sgr0)

define blue
	@tput setaf 4
	@echo " "
	@echo $1
	@echo " "
	@tput sgr0
endef
