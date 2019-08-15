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
