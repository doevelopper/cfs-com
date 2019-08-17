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

ARG BASE_IMAGE=docker.io/doevelopper/cfs-com-dev:0.0.1
FROM $BASE_IMAGE

USER root

# Java
#RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
#RUN add-apt-repository ppa:webupd8team/java
#RUN apt-get update
#RUN apt-get install -y oracle-java8-installer
#RUN rm -rf /var/cache/oracle-jdk8-installer

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

ENV OPENSSL_ROOT_DIR  /usr/

# Fetch and build GStreamer
ARG GST_VERSION=1.14.0

# http://www.linuxfromscratch.org/blfs/view/svn/multimedia/gstreamer10.html
RUN cd /tmp \
    && wget https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-${GST_VERSION}.tar.xz \
    && tar xvfJ gstreamer-${GST_VERSION}.tar.xz > /dev/null \
    && cd gstreamer-${GST_VERSION} \
    && ./configure --prefix=/usr --disable-gtk-doc \
    && make \
    && make install \
    && cd /tmp/

# gst-plugins-base
RUN cd /tmp \
    && wget https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-${GST_VERSION}.tar.xz \
    && tar xvfJ gst-plugins-base-${GST_VERSION}.tar.xz > /dev/null \
    && cd gst-plugins-base-${GST_VERSION} \
    && ./configure --prefix=/usr --disable-gtk-doc \
    && make \
    && make install \
    && cd /tmp/

# libnice
RUN cd /tmp \
    && git clone https://github.com/libnice/libnice.git \
    && cd libnice \
    && ./autogen.sh --prefix=/usr --with-gstreamer --enable-static --enable-static-plugins --enable-shared --without-gstreamer-0.10 --disable-gtk-doc \
    && make install \
    && cd /tmp/

# gst-plugins-good
RUN cd /tmp \
    && wget https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-${GST_VERSION}.tar.xz \
    && tar xvfJ gst-plugins-good-${GST_VERSION}.tar.xz > /dev/null \
    && cd gst-plugins-good-${GST_VERSION} \
    && ./configure --prefix=/usr --disable-gtk-doc \
    && make \
    && make install \
    && cd /tmp/

# gst-plugins-bad
RUN cd /tmp \
    && wget https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-${GST_VERSION}.tar.xz \
    && tar xvfJ gst-plugins-bad-${GST_VERSION}.tar.xz > /dev/null \
    && cd gst-plugins-bad-${GST_VERSION} \
    && ./configure --prefix=/usr --disable-gtk-doc \
    && make \
    && make install \
    && cd /tmp/

# gst-plugins-ugly
RUN cd /tmp \
    && wget https://gstreamer.freedesktop.org/src/gst-plugins-ugly/gst-plugins-ugly-${GST_VERSION}.tar.xz \
    && tar xvfJ gst-plugins-ugly-${GST_VERSION}.tar.xz > /dev/null \
    && cd gst-plugins-ugly-${GST_VERSION} \
    && ./configure --prefix=/usr --disable-gtk-doc \
    && make \
    && make install \
    && cd /tmp/ 

# gst-rtsp-server
RUN cd /tmp \
    && wget https://gstreamer.freedesktop.org/src/gst-rtsp-server/gst-rtsp-server-${GST_VERSION}.tar.xz \
    && tar xvfJ gst-rtsp-server-${GST_VERSION}.tar.xz > /dev/null \
    && cd gst-rtsp-server-${GST_VERSION} \
    && ./configure --prefix=/usr --disable-gtk-doc \
    && make \
    && make install \
    && cd /tmp/ \
    rm -rf gst*

RUN cd /tmp \
    && git clone --depth=1 --recurse-submodules https://github.com/eProsima/Fast-RTPS.git

RUN cd /tmp \
    && cd Fast-RTPS \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DSECURITY=ON -DPERFORMANCE_TESTS=ON  \
        -DTHIRDPARTY=ON -DBUILD_JAVA=ON -DPERFORMANCE_TESTS=ON  \
        -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS=ON  \
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON\
    && cmake --build build --target all --clean-first \
    && cmake --build build --target install
    # && cd /tmp \
    # && rm -rf Fast-RTPS

# Clone and install Micro XRCE-DDS Agent
#RUN git clone https://github.com/eProsima/Micro-XRCE-DDS-Agent.git agent \
#    && mkdir agent/build && cd agent/build \
#    && cmake -DTHIRDPARTY=ON -DVERBOSE=ON -DCMAKE_INSTALL_PREFIX=/usr/dds-qgent .. \
#    && make -j `nproc` install

ARG ACCOUNT
ENV ACCOUNT ${ACCOUNT:-developer}
RUN chown -R $ACCOUNT:$ACCOUNT /home/$ACCOUNT
USER $ACCOUNT
WORKDIR /home/$ACCOUNT
CMD ["/bin/bash"]
