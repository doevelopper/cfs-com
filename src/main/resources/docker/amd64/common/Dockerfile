# %W% %G% %U%
#        cfs-com/src/main/resources/docker/amd64/common/Dockerfile
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

ARG BASE_IMAGE=amd64/ubuntu:19.04
FROM $BASE_IMAGE

ARG ACCOUNT=developer
ARG LOG_OUTPUT

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN apt-get -qq -o Acquire::Check-Valid-Until="false" update --assume-yes \
    && apt-get -qq install --assume-yes --no-install-recommends \
        ca-certificates apt-transport-https \
        libtool autotools-dev autopoint autoconf automake make autoproject bison flex \
        build-essential git xz-utils unzip wget curl openssh-server openssh-client \
        gawk vim texinfo emacs25 gtk-doc-tools autogen autogen-doc \
        python-pip python-dev python-wheel cython python-setuptools \
        python3-pip python3-dev python3-wheel cython3 python3-setuptools \
        ruby ruby-dev \
        libglib2.0-dev libglib2.0-bin libglib2.0-0 \
        xvfb xauth libx11-xcb1 libfontconfig1 libfontconfig1-dev libdbus-1-3 libgl1-mesa-dev\
        libperl-dev perl perl-base perl-modules \
        > /dev/null 2>&1 \
   # && mkdir -pv /var/run/dbus \
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
   && ./configure\
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

#curl -L -C - -b "oraclelicense=accept-securebackup-cookie" -O 'https://download.oracle.com/otn/java/jdk/8u221-b11/230deb18db3e4014bb8e3e8324f81b43/jdk-8u221-linux-x64.tar.gz'
#  http://enos.itcollege.ee/~jpoial/allalaadimised/jdk8/jdk-8u212-linux-x64.tar.gz
# COPY jdk-8u212-linux-x64.tar.gz /tmp

RUN  cd /tmp \
   && curl -L -O -k https://github.com/frekele/oracle-java/releases/download/8u212-b10/jdk-8u212-linux-x64.tar.gz \
   && tar -xzf jdk-8u212-linux-x64.tar.gz -C /opt/ \
   && rm jdk-8u212-linux-x64.tar.gz

ENV MVN_VERSION ${MVN_VERSION:-3.6.1}
RUN cd /tmp \
   &&  wget --no-check-certificate \
   https://www-eu.apache.org/dist/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz \
   && tar -xzf apache-maven-${MVN_VERSION}-bin.tar.gz > /dev/null 2>&1 \
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
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local  \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install> /dev/null 2>&1 \
   && cd /tmp \
   && rm -rf uncrustify

RUN cd /tmp \
   && git clone --depth=1 https://github.com/danmar/cppcheck.git \
   && cd cppcheck \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
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

# RUN cd /tmp \
#    && git clone --depth=1 https://github.com/gflags/gflags.git \
#    && cd gflags \
#    && cmake -E make_directory build \
#    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/ \
#       # -DCMAKE_CONFIGURATION_TYPES="Debug;Release" -D GFLAGS_BUILD_TESTING=ON \
#       -DCMAKE_CONFIGURATION_TYPES=Release -D GFLAGS_BUILD_TESTING=ON \
#       -DGFLAGS_BUILD_SHARED_LIBS=ON -DGFLAGS_BUILD_STATIC_LIBS=ON \
#    && cmake --build build --target all --clean-first > /dev/null 2>&1 \
#    && cmake --build build --target install > /dev/null 2>&1 \
#    && cd /tmp \
#    && rm -rf gflags

# RUN cd /tmp \
#    && git clone --depth=1 https://github.com/google/glog.git \
#    && cd glog \
#    && cmake -E make_directory build \
#    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/ \
#    && cmake --build build --target all --clean-first > /dev/null 2>&1 \
#    && cmake --build build --target install > /dev/null 2>&1 \
#    && cd /tmp \
#    && rm -rf glog

RUN cd /tmp \
   && git clone --depth=1 --recurse-submodules https://github.com/google/crc32c.git \
   && cd crc32c \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/ \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install > /dev/null 2>&1 \
   && cd /tmp \
   && rm -rf crc32c

RUN cd /tmp \
   && git clone --depth=1 https://github.com/jeaye/stdman.git \
   && cd stdman \
   && ./configure --prefix=/usr/local \
   && make install > /dev/null 2>&1 \
   && cd /tmp \
   && rm -Rf stdman

ENV MANPATH=${MANPATH}:/usr/local/man:/usr/local/share/man:/usr/share/man:/usr/man

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
   && make clean  > /dev/null 2>&1\
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

# "Building IEEE doubles binary-decimal and decimal-binary ."
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
#    && GIT_SSL_NO_VERIFY=1 git clone --depth=1 -b OpenSSL_1_0_2-stable https://github.com/openssl/openssl.git  openssl \
   && GIT_SSL_NO_VERIFY=1 git clone --depth=1 --recurse-submodules https://github.com/openssl/openssl.git  openssl \
   && cd openssl \
#    && ./config --prefix=/usr shared enable-ec enable-ecdh enable-ecdsa \
#    && ./config --prefix=/usr  \
   && ./config --prefix=/usr shared  \
   && make > /dev/null 2>&1 \
   && make install > /dev/null 2>&1 \
   && cd /tmp \
   && rm -rf openssl

RUN cd /tmp \
   && git clone --depth=1 https://github.com/protocolbuffers/protobuf.git \
   && cd protobuf \
   && ./autogen.sh > /dev/null 2>&1  \
#    && ./configure --enable-samples --with-openssl=/usr --with-zlib=/usr --prefix=/usr/ \
   && ./configure --prefix=/usr/  \
   && make clean  > /dev/null 2>&1 \
   && make > /dev/null 2>&1 \
   && make install > /dev/null 2>&1 \
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

# Fetch and build GStreamer
# 1.14.5 1.15.90 1.16.0
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
    && cd /tmp/ \
    && rm -rf libnice \

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
# ENV LD_LIBRARY_PATH=$QT_BASE_DIR/lib/x86_64-linux-gnu:$QT_BASE_DIR/lib:$LD_LIBRARY_PATH
# ENV PKG_CONFIG_PATH=$QT_BASE_DIR/lib/pkgconfig:$PKG_CONFIG_PATH

# RUN cd /tmp \
#    && git clone  --depth=1 git://git.linuxtv.org/v4l-utils.git \
#    && cd v4l-utils \
#    && autoreconf -vfi \
#    && ./configure --prefix=/usr > /dev/null 2>&1 \
#    && make > /dev/null 2>&1 \
#    && make install > /dev/null 2>&1 \
#    && cd /tmp/ \
#    && rm -Rf v4l-utils

# RUN cd /tmp \
#    && git clone --depth=1 https://github.com/opencv/opencv.git \
#     && cd opencv \
#    && git clone --depth=1 https://github.com/opencv/opencv_contrib.git \
#     && cmake -E make_directory build \
#     && cmake -E chdir build cmake -DCMAKE_BUILD_TYPE=Release \
#       -DINSTALL_C_EXAMPLES=ON \
#       -DINSTALL_PYTHON_EXAMPLES=ON \
#       -DWITH_TBB=ON \
#       -DWITH_V4L=ON \
#       -DOPENCV_PYTHON3_INSTALL_PATH=/usr/opencv-py3/lib/python3.5/site-packages \
#       -DWITH_QT=ON \
#       -DWITH_OPENGL=ON \
#       -DOPENCV_EXTRA_MODULES_PATH=../opencv/opencv_contrib/modules \
#       -DBUILD_EXAMPLES=ON \
#       -DCMAKE_INSTALL_PREFIX=/usr/opencv .. \
#     && cmake --build build --target all --clean-first > /dev/null 2>&1 \
#     && cmake --build build --target install || true \
#     && cd /tmp \
#     && rm -Rf opencv


# RUN cd /tmp \
  # && wget -O vscode-amd64.deb  https://go.microsoft.com/fwlink/?LinkID=760868 \
  # && dpkg -i vscode-amd64.deb \
  # &&  rm vscode-amd64.deb

#ADD ./src/main/resources/docker/amd64/vscode-ext.sh /tmp/

#RUN cd /tmp \
#    && chmod +x vscode-ext.sh\
#    && ./vscode-ext.sh \
#    && rm -vf vscode-ext.sh

RUN echo -e '\033[36;1m ******* ADD USER ******** \033[0m' 

# RUN useradd -m $ACCOUNT \
#    && echo "$ACCOUNT:$ACCOUNT" | chpasswd \
#    && usermod --shell /bin/bash $ACCOUNT \
#    && usermod -aG sudo $ACCOUNT \
#    && echo "$ACCOUNT ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$ACCOUNT \
#    && chmod 0440 /etc/sudoers.d/$ACCOUNT \
#        # Replace 1000 with your user/group id
#    && usermod  --uid 1000 $ACCOUNT \
#    && groupmod --gid 1000 $ACCOUNT

# Add a new group '${ACCOUNT}s' with ID 1000
# Add a new user  '$ACCOUNT' with ID 1000
# Add $ACCOUNT to sudoers list with no password required
# Make 'bash' the default shell for everyone
RUN set -ex    cut -d: -f1 /etc/group
RUN set -ex    cut -d: -f1 /etc/passwd
RUN adduser --system --home /home/${ACCOUNT} --shell /bin/bash \
   --gecos GECOS --group --disabled-password --quiet ${ACCOUNT}
# Anyone in the $ACCOUNT group have read/write/execute permissions in the '/usr/local' path
# Others have read/execute permissions
# RUN chown -R ${ACCOUNT}s:${ACCOUNT} /home/${ACCOUNT}
#RUN chown -R $ACCOUNT:${ACCOUNT} /usr/local && chmod -R 775 /usr/local
# So $ACCOUNT can write to temp folder
RUN chmod 1777 -R /tmp
USER $ACCOUNT
WORKDIR /home/$ACCOUNT

RUN echo -e '\033[36;1m ******* CONTAINER START COMMAND ******** \033[0m'

CMD ["/bin/bash"]


# RUN cd /tmp \
#    && git clone --depth=1 --recurse-submodules https://github.com/KDAB/hotspot.git \
#    && cd hotspot \
#    && cmake -E make_directory build \
#    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/ \
#    && cmake --build build --target all --clean-first \
#    && CTEST_OUTPUT_ON_FAILURE=1 cmake --build build --target test \
#    && cmake --build build --target install \
#    && cd /tmp \
#    && rm -rf hotspot

# RUN cd /tmp \
#    && git clone --depth=1 --recurse-submodules https://github.com/apitrace/apitrace.git \
#    && cd apitrace \
#    && cmake -E make_directory build \
#    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/ \
#    && cmake --build build --target all --clean-first \
#    && CTEST_OUTPUT_ON_FAILURE=1 cmake --build build --target test \
#    && cmake --build build --target install \
#    && cd /tmp \
#    && rm -rf apitrace

# RUN cd /tmp \
   # && git clone --depth=1 https://github.com/google/statechart.git \
   # && cd statechart \
   # && bazel build //statechart/... \
   # && bazel test //statechart/... \
   # && bazel run //statechart/example:microwave_example_main -- --alsologtostderr \
   # && cd /tmp
#   && rm -rvf statechart

# install protobuf first, then grpc
# ENV GRPC_RELEASE_TAG v1.22.x
# RUN cd /tmp \
   # && git clone -b ${GRPC_RELEASE_TAG} https://github.com/grpc/grpc  \
   # && cd grpc \
   # && git submodule update --init \
   # && echo "--- installing protobuf ---" \
   # && cd third_party/protobuf \
      # ./autogen.sh \
   # && ./configure --enable-shared --prefix=/usr/  \
   # && make \
   # && make check \
   # && make install \
   # && make clean  \
   # && ldconfig \
   # && echo "--- installing grpc ---" \
   # && cd /tmp/grpc \
   # && make \
   # && make install \
   # && make clean \
   # && ldconfig \
   # && rm -Rf /tmp/grpc

# RUN cd /tmp \
#    && git clone -b $GST_VERSION --depth 1 git://anongit.freedesktop.org/git/gstreamer/gstreamer \
#    && cd gstreamer \
#    && git checkout ${GST_VERSION} \
#    && ./autogen.sh --prefix=/usr --disable-gtk-doc \
#    && make -j`nproc` \
#    && make install \
#    && cd /tmp/ \
#    && rm -rf /gstreamer

# need libjpeg-dev
# RUN cd /tmp \
#  &&   git clone --depth=1 https://github.com/Motion-Project/motion.git
   # cd motion  && \
   # autoreconf -fiv && \
   # ./configure && \
   # make clean && \
   # make && \
   # make install && \
   # cd .. && \
   # rm -fr motion
# http://www.smcc.demon.nl/camstream/download/camstream-0.27.tar.gz
# http://smcc.demon.nl/archief/camstream-0.26.3.tar.gz
# https://github.com/cisco/herisson.git
# https://github.com/cisco/mlspp.git
# https://github.com/cisco/openh264.git
# https://github.com/cisco/libsrtp.git

# RUN cd /tmp \
    # && GIT_SSL_NO_VERIFY=1 git clone --depth=1 --recurse-submodules https://github.com/wireshark/wireshark.git \
    # && cd wireshark \
    # && cmake -E make_directory build \
    # && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
    # && cmake --build build --target all --clean-first > /dev/null \
    # && cmake --build build --target install > /dev/null \
    # cd /tmp \
    # rm -Rf wireshark

# RUN cd /tmp \
   # && git clone --depth=1 https://github.com/Snaipe/Criterion.git \
    # && cd Criterion \
    # && cmake -E make_directory build \
    # && cmake -E chdir build cmake .. -DUSE_CPP14=1 -DCMAKE_INSTALL_PREFIX=/usr/local \
    # && cmake --build build --target all --clean-first \
    # && cmake --build build --target install || true \
    # && cd /tmp \
    # && rm -Rf Criterion

###################################################### WARNING ################################################################
 # Faild because linking agains wrong gtest... pthread .. the one in /usr/local/lib/libgmock.a 
 # overriden by some previous libraies
 # Same issue with capture-thread
# "Building translating between absolute and civil times"

# RUN cd /tmp \
   # && git clone --depth=1 https://github.com/google/cctz.git \
   # && cd cctz \
   # && cmake -E make_directory mybuild \
   # && cmake -E chdir mybuild cmake .. -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release \
      # -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_INSTALL_PREFIX=/usr \
      # -DCMAKE_CXX_STANDARD_LIBRARIES="" \
   # && cmake --build mybuild --target all  --clean-first \
   # && ctest \
   ##&& cmake --build mybuild --config Release --target install \
   # && cmake --build mybuild --target install \
   # && cd /tmp \
   # && rm -rf cctz
# Lost of dependencies ... protobuf build previously with my flags
# RUN cd /tmp \
   # && git clone --depth=1 https://github.com/google/bloaty.git \
   # && cd bloaty \
   # && cmake -E make_directory build \
   # && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/ \
   # && cmake --build build --target all --clean-first \
   # && cmake --build build --target install \
   # && cd /tmp \
   # && rm -rf bloaty

# RUN cd /tmp \
   # && git clone --depth=1 https://github.com/google/capture-thread.git \
   # && cd capture-thread \
   # && cmake -E make_directory build \
   # && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local  \
   # && cmake --build build --target all --clean-first  \
   # && cmake --build build --target install \
   # && cd /tmp \
   # && rm -rf capture-thread


#RUN cd /tmp \
#    && wget --no-check-certificate https://github.com/conan-io/conan/releases/download/1.18.1/conan-ubuntu-64_1_18_1.deb
#    && dpkg -i conan-ubuntu-64_1_18_1.deb \
#    && rm -vf conan-ubuntu-64_1_18_1.deb \
#    && conan user && \
#    pip3 install conan==1.18.1 conan_package_tools

#RUN cd /tmp \
#    && GIT_SSL_NO_VERIFY=1 git clone --depth=1 https://github.com/conan-io/conan.git \
#    && cd conan  \
#    && pip3 install -e . \
#    && pip install -r conans/requirements.txt \
#    && pip install -r conans/requirements_server.txt \
#    && pip install -r conans/requirements_dev.txt

    # && pip3 install --upgrade pip
    # && pip install -e .
    # && conan remote add conan-center https://conan.bintray.com
    # && conan remote update conan-center https://api.bintray.com/conan/conan/conan-center False \
    # && conan remote add conan-community https://api.bintray.com/conan/conan-community/conan
    # && conan remote add bincrafters https://api.bintray.com/conan/bincrafters/public-conan False
    # && conan remote add conan-transit https://api.bintray.com/conan/conan/conan-transit True
    # && pip install -r conans/requirements.txt

# Configure the remote.
#RUN conan remote add artifactory https://jfrog.io/artifactory/api/conan/POM-CONAN
#RUN conan user -p ${ARTIFACTORY_PSW} -r artifactory ${ARTIFACTORY_USR}
#RUN conan create --update -e ARTIFACTORY_USR=${ARTIFACTORY_USR} -e ARTIFACTORY_PSW=${ARTIFACTORY_PSW} -e AIMMS_HOME=/opt/aimms/ -s build_type=${BUILD_TYPE} . gridiq/dev
## Run deploy if configured to do so.
#RUN if [ "${BUILD_GOAL}" = "deploy" ]; then conan upload --all --force -c -r=artifactory src/main/cpp/*; fi
#RUN conan install . -s os=Linux -s os_build=Linux -s arch=x86_64 -s arch_build=x86_64 -s compiler=gcc -s compiler.version=7 -s compiler.libcxx=libstdc++11 && \
#    mkdir build && cd build && \
#    cmake .. -G "Unix Makefiles"
