.DEFAULT_GOAL:=help

ifeq ("$(origin V)", "command line")
    KBUILD_VERBOSE = $(V)
endif
ifndef KBUILD_VERBOSE
    KBUILD_VERBOSE = 0
endif

ifeq ($(KBUILD_VERBOSE),1)
    quiet =
    Q =
    QQ =
else
    quiet=quiet_
    Q = @
    QQ = > /dev/null
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

MAKEFLAGS += --no-print-directory

export BUILD_DIRECTORY ?= $(shell basename $(shell git rev-parse --show-toplevel))-build
export PRJNAME := $(shell basename $(shell git rev-parse --show-toplevel))
export BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
export HASH := $(shell git rev-parse HEAD)


ifeq ($(BRANCH),master)
    RELEASE_LEVEL := "CANDIDATE"
else ifeq ($(BRANCH),develop)
    RELEASE_LEVEL := "ALPHA"
else ifeq ($(BRANCH),release)
    RELEASE_LEVEL := "FINAL"
else ifeq ($(BRANCH),hotfix)
    RELEASE_LEVEL := "CANDIDATE"
else ifeq ($(BRANCH),feature)
    RELEASE_LEVEL := "CANDIDATE"
else
    RELEASE_LEVEL := "SNAPSHOOT"
endif

SHELL = /bin/sh
RM = /opt/bin/cmake -E remove -f

.PHONY : edit_cache
edit_cache: ## Special rule for the target edit_cache
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running interactive CMake command-line interface..."
	@$(CMAKE_COMMAND) -i .

.PHONY : rebuild_cache
rebuild_cache: ## rebuild cache
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running CMake to regenerate build system..."
	@$(CMAKE_COMMAND) -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR)

.PHONY: generate
generate: ## Create build directories
	@cmake -E make_directory ${BUILD_DIRECTORY}

.PHONY: configure
configure: generate ## Generate Cmake Build configurations in ${BUILD_DIRECTORY}
	@cmake -E chdir ${BUILD_DIRECTORY} cmake -G "Unix Makefiles" \
		"-DCMAKE_LINK_WHAT_YOU_USE=TRUE" ..
# \
		# "-DCMAKE_CXX_CPPLINT=/usr/local/bin/cpplint;--linelength=120;--extensions=cpp,hpp;--filter=-whitespace/braces;--exclude=$(shell pwd -P)/src/test/cpp/*;--exclude=$(shell pwd -P)/src/test/cpp/*/*" \
		# "-DCMAKE_CXX_CPPCHECK=/usr/local/bin/cppcheck;--template=gcc;--std=c++17;--quiet;--platform=unix64;--report-progress;--enable=warning,performance,portability,information,missingInclude,style;--project=$(shell pwd -P)/${BUILD_DIRECTORY}/compile_commands.json" \
		# -DCMAKE_PREFIX_PATH=/opt/dds \
		# -DCMAKE_INSTALL_PREFIX=$(basename $(pwd))-build/.local ..
#		"-DCMAKE_CXX_CPPLINT=/usr/local/bin/cpplint;--linelength=120;--include_what_you_use;--filter=$(shell pwd -P)/src/main/resources/configs/CPPLINT.cfg;--recursive;--extensions=cpp,hpp" \

.PHONY: compile
compile: configure ## Build projects main sources
	@cmake --build ${BUILD_DIRECTORY} --target compile

.PHONY: test
test: compile ## Build projects test sources and run unit test
	@cmake --build ${BUILD_DIRECTORY} --target test-compile
	@cmake --build ${BUILD_DIRECTORY} --target test

.PHONY: integration-test
integration-test: test ## Build integrations steps and run integrqtion test
	@cmake --build ${BUILD_DIRECTORY} --target integration-test

.PHONY: install
install: ## Install package in outpout directory build
	@cmake --build ${BUILD_DIRECTORY} --target install

.PHONY: verify
verify: ## Run all goals
	@cmake --build ${BUILD_DIRECTORY} --target all --clean-first

.PHONY: usage
usage: ## Displays all goals available for cmake build
	@cmake --build ${BUILD_DIRECTORY} --target help

.PHONY: clean
clean: ## Cleaned up the objects and intermediary files
	@cmake --build ${BUILD_DIRECTORY} --target clean

.PHONY: all
all: compile

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

