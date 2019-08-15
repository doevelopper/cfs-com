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

EMPTY               =
SPACE               = $(EMPTY) $(EMPTY)
MAKEDIR             = mkdir -p
DOCKER              = docker
RM                  = -rm -rf
BIN                 := /usr/bin
SHELL               = $(BIN)/env bash
DOCKER_SHELL        := $(BIN)/sh
PRINTF              := $(BIN)/printf
DF                  := $(BIN)/df
AWK                 := $(BIN)/awk
PERL                := $(BIN)/perl
PYTHON              := $(BIN)/python
PYTHON2             := $(BIN)/python2
PYTHON3             := $(BIN)/python3

DISPLAY             := @bash -c '  $(PRINTF) $(YELLOW); echo "=> $$1";  $(PRINTF) $(NC)'
UNAME_OS            := $(shell uname -s)
HOST_RYPE           := $(shell arch)
DATE              	:= $(shell date -u "+%b-%d-%Y")
CWD               	:= $(shell pwd -P)
TARGETS             ?= linux/amd64 linux/arm64v8 windows/amd64
# Define colors for console output

SH_DEFAULT          := $(shell echo '\033[00m')
SH_RED              := $(shell echo '\033[31m')
SH_GREEN            := $(shell echo '\033[32m')
SH_YELLOW           := $(shell echo '\033[33m')
SH_BLUE             := $(shell echo '\033[34m')
SH_PURPLE           := $(shell echo '\033[35m')
SH_CYAN             := $(shell echo '\033[36m')

UNDERLINE           = $(shell tput smul)
STANDOUT            = $(shell tput smso)
BOLD                = $(shell tput bold)
BLACK               = $(shell tput setaf 0)
RED                 = $(shell tput setaf 1)
GREEN               = $(shell tput setaf 2)
YELLOW              = $(shell tput setaf 3)
BLUR                = $(shell tput setaf 4)
MAGENTA             = $(shell tput setaf 5)
CYAN                = $(shell tput setaf 6)
WHITE               = $(shell tput setaf 7)
RESET               = $(shell tput sgr0)

define blue
	@tput setaf 4
	@echo " "
	@echo $1
	@echo " "
	@tput sgr0
endef
