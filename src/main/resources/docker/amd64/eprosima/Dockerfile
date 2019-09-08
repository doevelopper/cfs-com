#        cfs-com/src/main/resources/docker/amd64/omg/Dockerfile
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

ARG DDS_DEV_IMAGE=docker.io/doevelopper/cfs-com-common:latest
FROM $DDS_DEV_IMAGE

USER root
RUN cd /tmp \
    && git clone --depth=1 --recurse-submodules https://github.com/foonathan/memory.git \
    && cd memory \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_CXX_FLAGS="-Wall -Wextra -pedantic" -DCMAKE_INSTALL_PREFIX=/usr/local \
        -DBUILD_SHARED_LIBS=ON \
    && cmake --build build --target all --clean-first > /dev/null 2>&1 \
    && cmake --build build --target install > /dev/null 2>&1 \
    && cd /tmp \
    && rm -rf memory

ENV OPENSSL_ROOT_DIR  /usr/local

RUN cd /tmp \
    && git clone --depth=1 --recurse-submodules https://github.com/eProsima/Fast-RTPS.git

RUN cd /tmp \
    && cd Fast-RTPS \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DSECURITY=ON -DPERFORMANCE_TESTS=ON  \
        -DTHIRDPARTY=ON -DBUILD_JAVA=ON -DPERFORMANCE_TESTS=ON  \
        -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS=ON  \
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON\
    && cmake --build build --target all --clean-first > /dev/null \
    && cmake --build build --target install > /dev/null \
    && cd /tmp \
    && rm -rf Fast-RTPS

# Clone build and install Micro XRCE-DDS Agent and Client
# https://micro-xrce-dds.readthedocs.io/en/latest/installation.html
RUN cd /tmp \
    && git clone https://github.com/eProsima/Micro-XRCE-DDS.git \
    && cd Micro-XRCE-DDS \
    && cmake -E make_directory xrce-build \
    && cmake -E chdir xrce-build cmake .. -DTHIRDPARTY=ON -DVERBOSE=ON -DCMAKE_INSTALL_PREFIX=/usr/local/xrce-dds \
    && cmake --build xrce-build --target all --clean-first \
    && cmake --build xrce-build --target install \
    && cd /tmp \
    && rm -rf Micro-XRCE-DDS

#RUN cd /tmp \
#    && git clone --depth=1 --recurse-submodules https://github.com/eProsima/Integration-Service.git \
#    && cd Integration-Service \
#    && cmake -E make_directory service-build \
#    && cmake -E chdir service-build cmake .. -DTHIRDPARTY=ON -DCMAKE_INSTALL_PREFIX=/usr/local/dds-int-svc \
##        -DCMAKE_PREFIX_PATH="/usr/local;/usr/local/xrce-dds" \
#    && cmake --build service-build --target all --clean-first \
#    && cmake --build service-build --target install \
#    && cd /tmp \
#    && rm -rf Integration-Service

#RUN cd /tmp \
#    && git clone --depth=1 --recurse-submodules https://github.com/eProsima/Discovery-Server.git \
#    && cd Discovery-Server \
#    && cmake -E make_directory discovery-build \
#    && cmake -E chdir discovery-build cmake .. -DTHIRDPARTY=ON -DCMAKE_INSTALL_PREFIX=/usr/local/disco-svr \
#    && cmake --build discovery-build --target all --clean-first \
#    && cmake --build discovery-build --target install \
#    && cd /tmp \
#    && rm -rf Discovery-Server

ARG ACCOUNT=${ACCOUNT:-developer}
RUN adduser --system --home /home/${ACCOUNT} --shell /bin/bash \
        --gecos GECOS --group --disabled-password --quiet ${ACCOUNT}
USER $ACCOUNT
WORKDIR /home/$ACCOUNT
CMD ["/bin/bash"]

