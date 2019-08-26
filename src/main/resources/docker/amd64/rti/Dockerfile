#        cfs-com/src/main/resources/docker/amd64/rti/Dockerfile
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
ARG ACCOUNT=developer
ARG BASE_IMAGE=amd64/ubuntu:18.04
FROM $BASE_IMAGE

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN apt-get update -qq \
    && apt-get  -qq install --assume-yes --no-install-recommends libtool apt-transport-https \
         ca-certificates autotools-dev\
        git xz-utils unzip wget curl openssh-server  openssh-client  automake \
        bison flex build-essential gawk libgcrypt20-dev libcrypto++-dev vim texinfo \
        python-pip python3-pip python-dev python3-dev python-wheel cython cython3 python3-wheel \
        perl-base perl-modules zlib1g-dev gtk-doc-tools\
        libxml2-dev libxml2-utils python3-setuptools python-setuptools \
        libgnutls28-dev libcurl4-gnutls-dev libgnutls-openssl27 \
        mesa-common-dev libglu1-mesa-dev libpcap-dev \
        emacs25  rxvt-unicode-256color valgrind mscgen graphviz \
        x11-xserver-utils libxkbfile1 libxrender1 libxkbcommon-x11-0 libx11-dev \
        libglib2.0-dev libglib2.0-bin libglib2.0-0 \
        xvfb xauth libx11-xcb1 libfontconfig1 libfontconfig1-dev libdbus-1-3 libgl1-mesa-dev \
        libfontconfig libldap2-dev libldap-2.4-2  libmysql++-dev \
        unixodbc-dev libgdbm-dev libodb-pgsql-dev libcrossguid-dev  uuid-dev libossp-uuid-dev \
        libghc-uuid-dev libghc-uuid-types-dev ruby ruby-dev libelf-dev  elfutils libelf1 \
        libpulse-dev  make nfs-common xterm iputils-ping tmux vim-nox \
         > /dev/null 2>&1  \
    && apt-get clean --assume-yes  \
    && apt-get --assume-yes --quiet clean \
    && apt-get --assume-yes --quiet autoremove \
    && rm -rvf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/* \
    && rm -rf /usr/share/man/

ARG MAKEFLAGS

RUN cd /tmp \
   && curl -L -O -k http://ftp.gnu.org/gnu/gdb/gdb-8.3.tar.gz \
   && tar -xzf gdb-8.3.tar.gz \
   && cd gdb-8.3 \
   && ./configure \
   && make > /dev/null 2>&1 \
   && make install > /dev/null 2>&1 \
   && cd /tmp \
   && rm -rf gdb-8.3.tar.gz gdb-8.3

ENV CMAKE_MAJOR_VERSION ${CMAKE_MAJOR_VERSION:-3.15}
ENV CMAKE_VERSION ${CMAKE_VERSION:-${CMAKE_MAJOR_VERSION}.2}
RUN cd /tmp \
   && curl -L -O -k https://cmake.org/files/v${CMAKE_MAJOR_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
   && tar -xzf cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz  \
   && rm cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
   && mv cmake-${CMAKE_VERSION}-Linux-x86_64 /opt/cmake

RUN  cd /tmp \
   && curl -L -O -k  https://github.com/ninja-build/ninja/releases/download/v1.9.0/ninja-linux.zip\
   && unzip ninja-linux.zip  \
   && mv ninja /usr/bin/ninja \
   && rm ninja-linux.zip

RUN  cd /tmp \
   && curl -L -O -k https://github.com/frekele/oracle-java/releases/download/8u212-b10/jdk-8u212-linux-x64.tar.gz \
   && tar -xzf jdk-8u212-linux-x64.tar.gz -C /opt/ \
   && rm jdk-8u212-linux-x64.tar.gz

ENV MVN_VERSION ${MVN_VERSION:-3.6.1}
RUN cd /tmp \
   &&  wget --no-check-certificate \
   https://www-eu.apache.org/dist/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz \
   && tar -xzf apache-maven-${MVN_VERSION}-bin.tar.gz \
   && mv apache-maven-${MVN_VERSION}/ /opt/apache-maven \
   && rm -v apache-maven-${MVN_VERSION}-bin.tar.gz

ENV GRADLE_VERSION ${GRADLE_VERSION:-5.6}
RUN cd /tmp \
   && curl -L -O -k https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip \
   && mkdir -pv /opt/gradle \
   && unzip gradle-${GRADLE_VERSION}-bin.zip  \
   && mv gradle-${GRADLE_VERSION}  /opt/gradle/ \
   && rm -f gradle-${GRADLE_VERSION}-bin.zip


ENV JAVA_HOME /opt/jdk1.8.0_212
ENV JRE_HOME /opt/jdk1.8.0_212/jre
ENV M2_HOME /opt/apache-maven/
ENV M2 $M2_HOME/bin
ENV MAVEN_OPTS "-Dstyle.info=bold,green -Dstyle.project=bold,magenta -Dstyle.warning=bold,yellow \
        -Dstyle.mojo=bold,cyan -Xmx1048m -Xms256m -XX:MaxPermSize=512M"
ENV PATH $PATH:/opt/apache-maven/bin/:/opt/jdk1.8.0_212/bin:/opt/jdk1.8.0_212/jre/bin:/opt/cmake/bin
ENV PATH $PATH:/opt/gradle/gradle-${GRADLE_VERSION}/bin

ARG BAZEL_VERSION
ENV BAZEL_VERSION ${BAZEL_VERSION:-0.28.1}
RUN cd /tmp \
   && curl -L -O -k https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh \
   && chmod +x bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh  \
   && ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh  \
   && rm -f ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh

RUN cmake --version \
   && make --version \
   && gcc --version \
   && java -version \
   && mvn --version \
   && gradle -v \
   && bazel version \
   && conan --version || true

RUN cd /tmp \
   && git clone --depth=1 https://github.com/uncrustify/uncrustify.git \
   && cd uncrustify \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install > /dev/null 2>&1 \
   && cd /tmp \
   && rm -rf uncrustify

RUN cd /tmp \
   && git clone --depth=1 https://github.com/danmar/cppcheck.git \
   && cd cppcheck \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local  \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install > /dev/null 2>&1 \
   && cp --recursive --verbose cfg  /usr/local/bin || true \
   && cd /tmp \
   && rm -rf cppcheck

RUN cd /tmp \
   && git clone --depth=1 https://github.com/doxygen/doxygen.git  \
   && cd doxygen \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local  \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install > /dev/null 2>&1 \
   && cd /tmp \
   && rm -rf doxygen

RUN cd /tmp \
   && git clone --depth=1 https://github.com/google/googletest.git \
   && cd googletest \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install > /dev/null 2>&1 \
   && cd /tmp \
   && rm -rf googletest

RUN cd /tmp \
   && git clone --depth=1 https://github.com/google/benchmark.git \
   && cd benchmark \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DBENCHMARK_ENABLE_TESTING=OFF -DCMAKE_INSTALL_PREFIX=/usr/local  \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install > /dev/null 2>&1 \
   && cd /tmp \
   && rm -rf benchmark

RUN pip install -q --no-cache-dir conan \
   && pip install --upgrade conan_package_tools \
   && pip install cpplint \
   # && pip install cpplint-junit \
   && pip install cppcheck-junit \
   && pip install semver \
   && pip install semver-tool \
   && pip install lizard \
   && pip install cpp-demangle \
   && pip install polysquare-cmake-linter \
   # && pip install cmakedoc \
   && pip install cpp-coveralls \
   && pip install coverxygen \
   && pip install doxygen-junit

ARG BOOST_VERSION_MAJ=1
ARG BOOST_VERSION_MIN=69
ARG BOOST_VERSION_PATCH=0
ARG BOOST_VERSION=${BOOST_VERSION_MAJ}.${BOOST_VERSION_MIN}.${BOOST_VERSION_PATCH}
ARG BOOST_RELEASE=${BOOST_VERSION_MAJ}_${BOOST_VERSION_MIN}_${BOOST_VERSION_PATCH}
RUN cd /tmp \
   && curl -L -O -k https://dl.bintray.com/boostorg/release/${BOOST_VERSION}/source/boost_${BOOST_RELEASE}.tar.gz \
   && tar xzf boost_${BOOST_RELEASE}.tar.gz \
   && cd boost_${BOOST_RELEASE} \
   && ./bootstrap.sh --prefix=/usr/ --with-python=python3  > /dev/null 2>&1\
   && ./b2 --help \
   && ./b2 link=shared threading=multi variant=release address-model=64  > /dev/null 2>&1 \
   && ./b2 install --prefix=/usr/ > /dev/null 2>&1 \
   && cd /tmp \
   && rm -rf boost_${BOOST_RELEASE} boost_${BOOST_RELEASE}.tar.gz

#sml requires GCC >= 6.0.0
RUN cd /tmp \
   && git clone --depth=1 https://github.com/boost-experimental/sml.git \
   && cd sml \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release\
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install > /dev/null 2>&1 \
   && cd /tmp \
   && rm -rf sml

RUN cd /tmp \
   && git clone --depth=1 --recurse-submodules https://github.com/cucumber/cucumber-cpp.git \
   && cd cucumber-cpp \
   && gem install bundler -v 1.17.3 \
   && bundle install \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake -DCUKE_ENABLE_EXAMPLES=off \
		-DCMAKE_INSTALL_PREFIX=/usr/local .. \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install > /dev/null 2>&1 \
   && cd /tmp \
   && rm -rf cucumber-cpp

RUN cd /tmp \
   && git clone --depth=1 https://github.com/google/double-conversion.git \
   && cd double-conversion \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local  \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install > /dev/null 2>&1 \
   && cd /tmp \
   && rm -rf double-conversion

RUN cd /tmp \
   && curl -L -O -k http://lcamtuf.coredump.cx/afl/releases/afl-2.52b.tgz \
   && tar zxvf afl-2.52b.tgz --one-top-level=american-fuzzy-lop \
   && tar -xvzf afl-2.52b.tgz \
   && cd afl-2.52b \
   && make clean  > /dev/null 2>&1 \
   && make > /dev/null 2>&1 \
   && make DESTDIR=/opt/afl \
         BINDIR=/opt/afl/bin \
         DATAROOTDIR=/opt/afl/share \
         LIBDIR=/opt/afl/lib install  \
   && cd /tmp \
   && rm -rf afl-2.52b*

RUN cd /tmp \
   && git clone --depth=1 https://github.com/libcheck/check.git \
   && cd check \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/ \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && CTEST_OUTPUT_ON_FAILURE=1 cmake --build build --target test \
   && cmake --build build --target install || true \
   && cd /tmp \
   && rm -rf check

RUN cd /tmp \
   && git clone --depth=1 https://github.com/google/double-conversion.git  \
   && cd double-conversion \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DBUILD_TESTING=ON -DCMAKE_INSTALL_PREFIX=/usr/ \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
#   - test/cctest/cctest --list | tr -d '<' | xargs test/cctest/cctest \
   && cmake --build build --target install || true \
   && cd /tmp \
   && rm -rf double-conversion

RUN cd /tmp \
   && git clone --depth=1 https://github.com/protocolbuffers/protobuf.git \
   && cd protobuf \
   && ./autogen.sh > /dev/null 2>&1  \
#    && ./configure --enable-samples --with-openssl=/usr --with-zlib=/usr --prefix=/usr/ \
   && ./configure --prefix=/usr/  \
   && make clean  > /dev/null 2>&1 \
   && make > /dev/null 2>&1 \
   && make install \
   && cd /tmp \
   && rm -rf protobuf

ENV PROTOBUF_HOME /usr

RUN cd /tmp && curl -L -O -k http://www-us.apache.org/dist//xerces/c/3/sources/xerces-c-3.2.2.tar.gz \
   && tar -xzf xerces-c-3.2.2.tar.gz \
   && cd xerces-c-3.2.2/ \
   && ./configure --prefix=/usr/local \
           --enable-static --enable-shared --enable-netaccessor-socket \
           --enable-transcoder-gnuiconv --enable-transcoder-iconv \
           --enable-msgloader-inmemory --enable-xmlch-uint16_t --enable-xmlch-char16_t  \
   && make clean > /dev/null 2>&1 \
   && make > /dev/null 2>&1 \
   && make install > /dev/null 2>&1 \
   && cd /tmp \
   && rm xerces-c-3.2.2.tar.gz \
   && rm -rf xerces-c-3.2.2/

ARG APR_VERSION=1.7.0
RUN cd /tmp \
   && curl -L -O -k https://www-us.apache.org/dist/apr/apr-${APR_VERSION}.tar.gz  \
   && tar -xzf apr-${APR_VERSION}.tar.gz \
   && cd apr-${APR_VERSION} \
   && ./configure --prefix=/usr/ --enable-threads --enable-posix-shm \
        --enable-allocator-guard-pages --enable-pool-concurrency-check --enable-other-child  \
   && make clean > /dev/null 2>&1 \
   && make > /dev/null 2>&1 \
   && make install > /dev/null 2>&1 \
   && cd /tmp \
   && rm -rf apr-${APR_VERSION}.tar.gz apr-${APR_VERSION}

RUN cd /tmp \
   && git clone --depth=1 https://github.com/libexpat/libexpat.git  \
   && cd libexpat/expat  \
   && ./buildconf.sh > /dev/null 2>&1 \
   && ./configure CPPFLAGS=-DXML_LARGE_SIZE --without-docbook --prefix=/usr/ \
   && make > /dev/null 2>&1 \
   && make install > /dev/null 2>&1 \
   && cd /tmp \
   && rm -rf libexpat

ARG APU_VERSION=1.6.1
RUN cd /tmp \
   && curl -L -O -k https://www-us.apache.org/dist//apr/apr-util-${APU_VERSION}.tar.gz  \
   && tar -xzf apr-util-${APU_VERSION}.tar.gz  \
   && cd apr-util-${APU_VERSION} \
   && ./configure --prefix=/usr/ --with-apr=/usr/ --with-expat=/usr/  \
   && make clean > /dev/null 2>&1  \
   && make > /dev/null 2>&1 \
   && make install > /dev/null 2>&1 \
   && cd /tmp \
   && rm -rf apr-util-${APU_VERSION}.tar.gz apr-util-${APU_VERSION}

RUN cd /tmp \
   && GIT_SSL_NO_VERIFY=1 git clone --depth=1 https://gitbox.apache.org/repos/asf/logging-log4cxx.git  \
   && cd logging-log4cxx  \
   && ./autogen.sh \
   && ./configure --prefix=/usr/ --with-apr=/usr/ --with-apr-util=/usr/ \
        --enable-char --enable-wchar_t --with-charset=utf-8 --with-logchar=utf-8  \
   && make clean > /dev/null 2>&1 \
   && make > /dev/null 2>&1 \
   && make install > /dev/null 2>&1 \
   && cd /tmp \
   && rm -rf logging-log4cxx

RUN cd /tmp \
	&& git clone --depth=1 https://github.com/catchorg/Catch2.git \
	&& cd Catch2 \
	&& cmake -E make_directory build \
	&& cmake -E chdir build cmake .. -DUSE_CPP14=1 -DCMAKE_INSTALL_PREFIX=/usr/local \
	&& cmake --build build --target all --clean-first > /dev/null 2>&1 \
	&& cmake --build build --target install || true \
	&& cd /tmp \
	&& rm -Rf Catch2

RUN cd /tmp \
	&& git clone --depth=1 https://github.com/google/breakpad.git \
	&& cd breakpad \
	&& git clone https://chromium.googlesource.com/linux-syscall-support src/third_party/lss \
	&& ./configure --prefix=/usr/local  \
	&& make > /dev/null 2>&1 \
	&& make install > /dev/null 2>&1 \
	&& cd /tmp \
	&& rm -Rf breakpad

RUN cd /opt \
   && git clone https://chromium.googlesource.com/chromium/tools/depot_tools

ENV  PATH /opt/depot_tools:$PATH

ARG GST_VERSION=1.14.0
# http://www.linuxfromscratch.org/blfs/view/svn/multimedia/gstreamer10.html
RUN cd /tmp \
    && wget https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-${GST_VERSION}.tar.xz \
    && tar xvfJ gstreamer-${GST_VERSION}.tar.xz > /dev/null \
    && cd gstreamer-${GST_VERSION} \
    && ./configure --prefix=/usr --disable-gtk-doc \
    && make > /dev/null 2>&1 \
    && make install > /dev/null 2>&1 \
    && cd /tmp/

# gst-plugins-base
RUN cd /tmp \
    && wget https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-${GST_VERSION}.tar.xz \
    && tar xvfJ gst-plugins-base-${GST_VERSION}.tar.xz > /dev/null \
    && cd gst-plugins-base-${GST_VERSION} \
    && ./configure --prefix=/usr --disable-gtk-doc \
    && make > /dev/null 2>&1 \
    && make install > /dev/null 2>&1 \
    && cd /tmp/

# libnice
RUN cd /tmp \
    && git clone https://github.com/libnice/libnice.git \
    && cd libnice \
    && ./autogen.sh --prefix=/usr \
      --with-gstreamer --enable-static --enable-static-plugins \
      --enable-shared --without-gstreamer-0.10 --disable-gtk-doc \
    && make install > /dev/null 2>&1 \
    && cd /tmp/

# gst-plugins-good
RUN cd /tmp \
    && wget https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-${GST_VERSION}.tar.xz \
    && tar xvfJ gst-plugins-good-${GST_VERSION}.tar.xz > /dev/null \
    && cd gst-plugins-good-${GST_VERSION} \
    && ./configure --prefix=/usr --disable-gtk-doc \
    && make > /dev/null 2>&1 \
    && make install > /dev/null 2>&1 \
    && cd /tmp/

# gst-plugins-bad
RUN cd /tmp \
    && wget https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-${GST_VERSION}.tar.xz \
    && tar xvfJ gst-plugins-bad-${GST_VERSION}.tar.xz > /dev/null \
    && cd gst-plugins-bad-${GST_VERSION} \
    && ./configure --prefix=/usr --disable-gtk-doc \
    && make > /dev/null 2>&1 \
    && make install > /dev/null 2>&1 \
    && cd /tmp/

# gst-plugins-ugly
RUN cd /tmp \
    && wget https://gstreamer.freedesktop.org/src/gst-plugins-ugly/gst-plugins-ugly-${GST_VERSION}.tar.xz \
    && tar xvfJ gst-plugins-ugly-${GST_VERSION}.tar.xz > /dev/null \
    && cd gst-plugins-ugly-${GST_VERSION} \
    && ./configure --prefix=/usr --disable-gtk-doc \
    && make > /dev/null 2>&1 \
    && make install > /dev/null 2>&1 \
    && cd /tmp/

# gst-rtsp-server
RUN cd /tmp \
    && wget https://gstreamer.freedesktop.org/src/gst-rtsp-server/gst-rtsp-server-${GST_VERSION}.tar.xz \
    && tar xvfJ gst-rtsp-server-${GST_VERSION}.tar.xz > /dev/null \
    && cd gst-rtsp-server-${GST_VERSION} \
    && ./configure --prefix=/usr --disable-gtk-doc \
    && make > /dev/null 2>&1 \
    && make install > /dev/null 2>&1 \
    && cd /tmp/ \
    rm -rf gst*

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get -qq install --assume-yes --no-install-recommends nodejs

ENV Q_MAJOR_VERSION ${Q_MAJOR_VERSION:-5.13}
ENV Q_VERSION ${Q_VERSION:-${Q_MAJOR_VERSION}.0}
ENV QT_SHA_256 0cd82c80287a783bd5db1339b6184803d57517c9450ffe16f505254853f0a41f
ENV QT_MD5 c839aed9d551bdc8411a0a33e5ae46f3

COPY qt-installer-noninteractive.qs /tmp
COPY qt-installer-script.qs /tmp

# COPY qt-opensource-linux-x64-${Q_VERSION}.run /tmp
# RUN objdump -p ./qt-opensource-linux-x64-${Q_VERSION}.run | grep NEEDED

RUN cd /tmp \
   && curl -L -O "http://download.qt.io/official_releases/qt/${Q_MAJOR_VERSION}/${Q_VERSION}/qt-opensource-linux-x64-${Q_VERSION}.run" \
   && chmod +x ./qt-installer-noninteractive.qs \
   && chmod +x ./qt-installer-script.qs \
   && chmod +x ./qt-opensource-linux-x64-${Q_VERSION}.run \   
   && xvfb-run ./qt-opensource-linux-x64-${Q_VERSION}.run --script ./qt-installer-script.qs --platform minimal --verbose > /dev/null 2>&1 \
   && rm -vf ./qt-opensource-linux-x64-${Q_VERSION}.run

ENV QT_INSTALL_DIR=/opt/qt
ENV QTDIR=${QT_INSTALL_DIR}/${Q_VERSION}/gcc_64
ENV CMAKE_PREFIX_PATH=${QT_INSTALL_DIR}/${Q_VERSION}/gcc_64:$CMAKE_PREFIX_PATH
ENV PATH="${QTDIR}/bin/:${QT_INSTALL_DIR}/Tools/QtCreator/bin:${PATH}"

RUN cd /tmp \
	&& git clone git://git.linuxtv.org/v4l-utils.git \
	&& cd v4l-utils \
	&& autoreconf -vfi \
	&& ./configure --prefix=/usr \
    && make > /dev/null 2>&1 \
    && make install > /dev/null 2>&1 \
    && cd /tmp/ \
    && rm -Rf v4l-utils

RUN cd /tmp \
	&& git clone --depth=1 https://github.com/opencv/opencv.git \
    && cd opencv \
	&& git clone --depth=1 https://github.com/opencv/opencv_contrib.git \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D INSTALL_C_EXAMPLES=ON \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      -D WITH_TBB=ON \
      -D WITH_V4L=ON \
      -D OPENCV_PYTHON3_INSTALL_PATH=/usr/opencv-py3/lib/python3.5/site-packages \
      -D WITH_QT=ON \
      -D WITH_OPENGL=ON \
      -D OPENCV_EXTRA_MODULES_PATH=../opencv/opencv_contrib/modules \
      -D BUILD_EXAMPLES=ON \
      -DCMAKE_INSTALL_PREFIX=/usr/opencv \
    && cmake --build build --target all --clean-first > /dev/null 2>&1 \
    && cmake --build build --target install || true \
    && cd /tmp \
    && rm -Rf opencv

RUN cd /tmp/ \
# kept OpenSSL_1_0_2 for compatibility with the one provided by RTI (openssl-1.0.2n-5.3.1-host-x64Linux.rtipkg)
    && GIT_SSL_NO_VERIFY=1 git clone --depth=1 -b OpenSSL_1_0_2-stable https://github.com/openssl/openssl.git  openssl \
    && cd openssl \
#    && ./config --prefix=/usr shared enable-ec enable-ecdh enable-ecdsa \
    && ./config --prefix=/usr  \
    && make > /dev/null 2>&1 \
    && make install > /dev/null 2>&1 \
    && cd /tmp/ \
    && rm -rvf openssl

ARG RTI_DDS_VERSION=6.0.0

# COPY src/main/resources/docker/amd64/rti/packages/rti_connext_dds-${RTI_DDS_VERSION}-pro-host-x64Linux.run /tmp/
# COPY src/main/resources/docker/amd64/rti/packages/rti_license.dat /opt/rti_connext_dds-${RTI_DDS_VERSION}/
# COPY src/main/resources/docker/amd64/rti/packages/*.rtipkg  /tmp/
# COPY src/main/resources/docker/amd64/rti/packages/*.tar.gz  /tmp/

RUN [ -z "$CI_DOMAIN" ] \
    && cd /tmp/ \
    && chmod +x /tmp/rti_connext_dds-${RTI_DDS_VERSION}-pro-host-x64Linux.run  \
    && ./rti_connext_dds-${RTI_DDS_VERSION}-pro-host-x64Linux.run  --mode unattended --prefix /opt --disable_copy_examples true \
    && rm -rvf /tmp/rti_connext_dds-${RTI_DDS_VERSION}-pro-host-x64Linux.run \
    || :

ARG AMD_PREFIX=x64Linux3gcc5.4.0
ENV NDDSHOME=/opt/rti_connext_dds-${RTI_DDS_VERSION}
ENV PATH="${PATH}:${NDDSHOME}/bin"
ENV LD_LIBRARY_PATH=/opt/rti_connext_dds-${RTI_DDS_VERSION}/lib/${AMD_PREFIX}

RUN [ -z "$CI_DOMAIN" ] \
    && cd /tmp/ \
    && rtipkginstall -unattended rti_limited_bandwidth_plugins-6.0.0-x64Linux3gcc5.4.0.rtipkg \
    && rtipkginstall -unattended rti_security_plugins-6.0.0-target-x64Linux3gcc5.4.0.rtipkg \
    && rtipkginstall -unattended rti_connext_dds-6.0.0-pro-target-x64Linux3gcc5.4.0.rtipkg \
    && rtipkginstall -unattended rti_tls_support-6.0.0-x64Linux3gcc5.4.0.rtipkg \
    && rtipkginstall -unattended rti_secure_wan-6.0.0-x64Linux3gcc5.4.0.rtipkg \
    && rtipkginstall -unattended rti_limited_bandwidth_plugins_host-6.0.0-x64Linux.rtipkg \
    && rtipkginstall -unattended rti_web_integration_service-6.0.0-x64Linux.rtipkg \
    && rtipkginstall -unattended rti_security_plugins-6.0.0-host-x64Linux.rtipkg \
    && rtipkginstall -unattended rti_database_integration-6.0.0-x64Linux.rtipkg \
    && rtipkginstall -unattended rti_tls_host_support-6.0.0-x64Linux.rtipkg \
    && rtipkginstall -unattended rti_connext_dds_micro-3.0.0-Windows.rtipkg \
    && rtipkginstall -unattended openssl-1.0.2o-6.0.0-host-x64Linux.rtipkg \
    && rtipkginstall -unattended rti_secure_wan_host-6.0.0-x64Linux.rtipkg \
    && rtipkginstall -unattended rti_queuing_service-6.0.0-x64Linux.rtipkg \
    && rtipkginstall -unattended rti_connext_dds_micro-3.0.0-Unix.rtipkg \
    # && rtipkginstall -unattended rti_limited_bandwidth_plugins-6.0.0-x64Linux4gcc7.3.0.rtipkg \
    # && rtipkginstall -unattended rti_security_plugins-6.0.0-target-x64Linux4gcc7.3.0.rtipkg \
    # && rtipkginstall -unattended rti_connext_dds-6.0.0-pro-target-x64Linux4gcc7.3.0.rtipkg \
    # && rtipkginstall -unattended rti_tls_support-6.0.0-x64Linux4gcc7.3.0.rtipkg \
    # && rtipkginstall -unattended rti_secure_wan-6.0.0-x64Linux4gcc7.3.0.rtipkg \
    && rtipkginstall -unattended rti_security_plugins-6.0.0-target-armv8Linux4.4gcc5.4.0.rtipkg \
    && rtipkginstall -unattended rti_connext_dds-6.0.0-pro-target-armv8Linux4.4gcc5.4.0.rtipkg \
    && rtipkginstall -unattended rti_tls_support-6.0.0-armv8Linux4.4gcc5.4.0.rtipkg \
    && rm -rvf /tmp/*.rtipkg \
    || :

RUN [ -z "$CI_DOMAIN" ] \
    && cd /tmp/ \
    # && mkdir -pv /opt/rti_connext_openssl/{target-x64Linux3gcc5.4.0,target-x64Linux4gcc7.3.0,target-armv8Linux4.4gcc5.4.0} \
    && mkdir -pv /opt/rti_connext_openssl/target-x64Linux3gcc5.4.0 \
    && mkdir -pv /opt/rti_connext_openssl/target-x64Linux4gcc7.3.0 \
    && mkdir -pv /opt/rti_connext_openssl/target-armv8Linux4.4gcc5.4.0 \
    && tar -zvxf openssl-1.0.2o-target-armv8Linux4.4gcc5.4.0.tar.gz -C /opt/rti_connext_openssl/target-armv8Linux4.4gcc5.4.0 --strip-components=1 \
    # && tar -zvxf openssl-1.0.2o-target-x64Linux4gcc7.3.0.tar.gz -C /opt/rti_connext_openssl/target-x64Linux4gcc7.3.0 --strip-components=1 \
    && tar -zvxf openssl-1.0.2o-target-x64Linux3gcc5.4.0.tar.gz -C /opt/rti_connext_openssl/target-x64Linux3gcc5.4.0 --strip-components=1 \
    && rm -rvf /tmp/*.tar.gz \
    || :


RUN useradd -m $ACCOUNT \
   && echo "$ACCOUNT:$ACCOUNT" | chpasswd \
   && usermod --shell /bin/bash $ACCOUNT \
   && usermod -aG sudo $ACCOUNT \
   && echo "$ACCOUNT ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$ACCOUNT \
   && chmod 0440 /etc/sudoers.d/$ACCOUNT \
#        # Replace 1000 with your user/group id
   && usermod  --uid 1000 $ACCOUNT \
   && groupmod --gid 1000 $ACCOUNT
# ENTRYPOINT rtilauncher
# ENTRYPOINT ["/opt/rti_connext_dds-6.0.0/bin/rtipersistenceservice"]
# CMD ["-cfgFile","/config.xml","-cfgName","gets_persistence"]

CMD ["/bin/bash"]

