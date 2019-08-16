# %W% %G% %U%
#        cfs-com/src/main/resources/docker/makefiles/git-variables.mk
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

VERSION             := $(shell git describe --tags --long --dirty --always | \
                        sed 's/v\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)-\?.*-\([0-9]*\)-\(.*\)/\1 \2 \3 \4 \5/g')
SHA1              	:= $(shell git rev-parse HEAD)
SHORT_SHA1        	:= $(shell git rev-parse --short=5 HEAD)
GIT_STATUS        	:= $(shell git status --porcelain)
GIT_BRANCH        	:= $(shell git rev-parse --abbrev-ref HEAD)
GIT_BRANCH_STR    	:= $(shell git rev-parse --abbrev-ref HEAD | tr '/' '_')
GIT_REPO          	:= $(shell git config --local remote.origin.url | \
                        sed -e 's/.git//g' -e 's/^.*\.com[:/]//g' | tr '/' '_' 2> /dev/null)
GIT_REPOS_URL     	:= $(shell git config --get remote.origin.url)
CURRENT_BRANCH      := $(shell git rev-parse --abbrev-ref HEAD)
GIT_BRANCHES        := $(shell git for-each-ref --format='%(refname:short)' refs/heads/ | xargs echo)
GIT_REMOTES         := $(shell git remote | xargs echo )
GIT_ROOTDIR         := $(shell git rev-parse --show-toplevel)
GIT_DIRTY           := $(shell git diff --shortstat 2> /dev/null | tail -n1 )
LAST_TAG_COMMIT     := $(shell git rev-list --tags --max-count=1)
GIT_COMMITS         := $(shell git log --oneline ${LAST_TAG}..HEAD | wc -l | tr -d ' ')
GIT_REVISION        := $(shell git rev-parse --short=8 HEAD || echo unknown)
# LAST_TAG            := $(shell git describe --tags $(LAST_TAG_COMMIT) )
GIT_LAST_TAG        := $(git log --first-parent --pretty="%d" | \
                         grep -E "tag: v[0-9]+\.[0-9]+\.[0-9]+(\)|,)" -o | \
                         grep "v[0-9]*\.[0-9]*\.[0-9]*" -o | head -n 1)

