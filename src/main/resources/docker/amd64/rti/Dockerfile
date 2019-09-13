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

ARG BASE_IMAGE=amd64/ubuntu:18.04
FROM $BASE_IMAGE

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN apt-get -qq -o Acquire::Check-Valid-Until="false" update --assume-yes \
    && apt-get -qq install --assume-yes --no-install-recommends \
        ca-certificates apt-transport-https \
        libtool autotools-dev autopoint autoconf automake make autoproject bison flex \
        build-essential git xz-utils unzip wget curl openssh-server openssh-client \
        gawk vim vim-nox texinfo emacs25 gtk-doc-tools autogen autogen-doc \
        python-pip python-dev python-wheel cython python-setuptools \
        python3-pip python3-dev python3-wheel cython3 python3-setuptools \
        ruby ruby-dev libjpeg-dev libudev-dev \
        libglib2.0-dev libglib2.0-bin libglib2.0-0 \
        xvfb xauth libx11-xcb1 libfontconfig1 libfontconfig1-dev libdbus-1-3 libgl1-mesa-dev \
        libperl-dev perl perl-base perl-modules \
        yasm nasm xotcl-dev tcl-expect-dev tcl-dev \
        libpulse-dev libva-dev libxv-dev libelf-dev  elfutils libelf1 \
        libavformat-dev libavutil-dev libdlna-dev libavcodec-dev uvcdynctrl \
        libtsan0-dbg libtsan0 valgrind valgrind-dbg mscgen graphviz xdo \
        display-dhammapada fortunes lsb-printing \
        libc6-dev libmpfr-dev \
        libcrypto++-dev libgcrypt20-dev libpcap-dev libwiretap-dev bittwist \
        gnutls-bin ntopng pcaputils python-pcapy python-pypcap tcpick tcpspy libgnutls30 \
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
   && ./configure --prefix=/usr/local \
   && make > /dev/null 2>&1 \
   && make install > /dev/null 2>&1 \
   && cd /tmp \
   && rm -rf gdb-8.3.tar.gz gdb-8.3

ENV CMAKE_MAJOR_VERSION ${CMAKE_MAJOR_VERSION:-3.15}
ENV CMAKE_VERSION ${CMAKE_VERSION:-${CMAKE_MAJOR_VERSION}.3}
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

ENV MVN_VERSION ${MVN_VERSION:-3.6.2}
RUN cd /tmp \
   &&  wget --no-check-certificate \
   https://www-eu.apache.org/dist/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz \
   && tar -xzf apache-maven-${MVN_VERSION}-bin.tar.gz > /dev/null 2>&1 \
   && mv apache-maven-${MVN_VERSION}/ /opt/apache-maven \
   && rm -v apache-maven-${MVN_VERSION}-bin.tar.gz

ENV GRADLE_VERSION ${GRADLE_VERSION:-5.6.2}
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
ENV BAZEL_VERSION ${BAZEL_VERSION:-0.29.0}
RUN cd /tmp \
   && curl -L -O -k https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh \
   && chmod +x bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh  \
   && ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh  \
   && rm -f ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh

RUN pip install -q --no-cache-dir conan \
   && pip install --upgrade conan_package_tools \
   && pip install cpplint \
   && pip3 install meson \
   # && pip install cpplint-junit \
   && pip install cppcheck-junit \
   && pip install semver \
   && pip install semver-tool \
   && pip install lizard \
   && pip install cpp-demangle \
   && pip install polysquare-cmake-linter \
   && pip3 install cmakedoc \
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
   && cmake --build build --target install \
   && cd /tmp \
   && rm -rf uncrustify

RUN cd /tmp \
   && git clone --depth=1 https://github.com/danmar/cppcheck.git \
   && cd cppcheck \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install \
   && cp --recursive --verbose cfg  /usr/local/bin || true \
   && cd /tmp \
   && rm -rf cppcheck

RUN cd /tmp \
   && git clone --depth=1 https://github.com/doxygen/doxygen.git  \
   && cd doxygen \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local  \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install \
   && cd /tmp \
   && rm -rf doxygen

RUN cd /tmp \
   && git clone --depth=1 https://github.com/google/googletest.git \
   && cd googletest \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install \
   && cd /tmp \
   && rm -rf googletest

RUN cd /tmp \
   && git clone --depth=1 https://github.com/google/benchmark.git \
   && cd benchmark \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DBENCHMARK_ENABLE_TESTING=OFF -DCMAKE_INSTALL_PREFIX=/usr/local  \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install \
   && cd /tmp \
   && rm -rf benchmark

RUN cd /tmp \
   && git clone --depth=1 https://github.com/gflags/gflags.git \
   && cd gflags \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
#       # -DCMAKE_CONFIGURATION_TYPES="Debug;Release" -DGFLAGS_BUILD_TESTING=ON \
       -DCMAKE_CONFIGURATION_TYPES=Release -DGFLAGS_BUILD_TESTING=OFF \
       -DGFLAGS_BUILD_SHARED_LIBS=ON -DGFLAGS_BUILD_STATIC_LIBS=ON \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install \
   && cd /tmp \
   && rm -rf gflags

RUN cd /tmp \
   && git clone --depth=1 https://github.com/google/glog.git \
   && cd glog \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install > /dev/null 2>&1 \
   && cd /tmp \
   && rm -rf glog

RUN cd /tmp \
   && git clone --depth=1 --recurse-submodules https://github.com/google/crc32c.git \
   && cd crc32c \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
        -DCRC32C_BUILD_TESTS=0 -DCRC32C_BUILD_BENCHMARKS=0 \
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
   && ./bootstrap.sh --prefix=/usr/local --with-python=python3  > /dev/null 2>&1\
   && ./b2 --help \
   && ./b2 link=shared threading=multi variant=release address-model=64 > /dev/null 2>&1 \
   && ./b2 install --prefix=/usr/local > /dev/null 2>&1 \
   && cd /tmp \
   && rm -rf boost_${BOOST_RELEASE} boost_${BOOST_RELEASE}.tar.gz

#sml requires GCC >= 6.0.0
RUN cd /tmp \
   && git clone --depth=1 https://github.com/boost-experimental/sml.git \
   && cd sml \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release\
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install \
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
   && cmake --build build --target install \
   && cd /tmp \
   && rm -rf cucumber-cpp

RUN cd /tmp \
   && git clone --depth=1 https://github.com/google/double-conversion.git \
   && cd double-conversion \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local  \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install \
   && cd /tmp \
   && rm -rf double-conversion


RUN cd /tmp \
   && curl -L -O -k http://lcamtuf.coredump.cx/afl/releases/afl-2.52b.tgz \
   && tar zxvf afl-2.52b.tgz --one-top-level=american-fuzzy-lop \
   && tar -xvzf afl-2.52b.tgz \
   && cd afl-2.52b \
   && make clean  > /dev/null 2>&1\
   && make > /dev/null 2>&1 \
   # && make DESTDIR=/opt/afl  BINDIR=/opt/afl/bin DATAROOTDIR=/opt/afl/share LIBDIR=/opt/afl/lib install \
   && make DESTDIR=/usr/local install \
   && cd /tmp \
   && rm -rf afl-2.52b* american-fuzzy-lop

RUN cd /tmp \
   && git clone --depth=1 https://github.com/libcheck/check.git \
   && cd check \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
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
   && cmake -E chdir build cmake .. -DBUILD_TESTING=ON -DCMAKE_INSTALL_PREFIX=/usr/local \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
#   - test/cctest/cctest --list | tr -d '<' | xargs test/cctest/cctest \
   && cmake --build build --target install || true \
   && cd /tmp \
   && rm -rf double-conversion


RUN cd /tmp/ \
# kept OpenSSL_1_0_2 for compatibility with the one provided by RTI (openssl-1.0.2n-5.3.1-host-x64Linux.rtipkg)
    && GIT_SSL_NO_VERIFY=1 git clone --depth=1 -b OpenSSL_1_0_2-stable https://github.com/openssl/openssl.git  openssl \
    && cd openssl \
#    && ./config --prefix=/usr shared enable-ec enable-ecdh enable-ecdsa \
    && ./config --prefix=/usr  \
    && make > /dev/null 2>&1 \
    && make install \
    && cd /tmp/ \
    && rm -rvf openssl

RUN cd /tmp \
   && git clone --depth=1 https://github.com/protocolbuffers/protobuf.git \
   && cd protobuf \
   && ./autogen.sh > /dev/null 2>&1  \
   && ./configure --enable-samples --with-openssl=/usr --with-zlib=/usr --enable-silent-rules --prefix=/usr/ \
   # && ./configure --prefix=/usr/local  \
   && make clean  > /dev/null 2>&1 \
   && make > /dev/null 2>&1 \
   && make install \
   && cd /tmp \
   && rm -rf protobuf

ENV PROTOBUF_HOME /usr/local

RUN cd /tmp && curl -L -O -k http://www-us.apache.org/dist//xerces/c/3/sources/xerces-c-3.2.2.tar.gz \
   && tar -xzf xerces-c-3.2.2.tar.gz \
   && cd xerces-c-3.2.2/ \
   && ./configure --prefix=/usr/local \
           --enable-static --enable-shared --enable-netaccessor-socket \
           --enable-transcoder-gnuiconv --enable-transcoder-iconv \
           --enable-msgloader-inmemory --enable-xmlch-uint16_t --enable-xmlch-char16_t  \
   && make clean > /dev/null 2>&1 \
   && make > /dev/null 2>&1 \
   && make install \
   && cd /tmp \
   && rm xerces-c-3.2.2.tar.gz \
   && rm -rf xerces-c-3.2.2/

ARG APR_VERSION=1.7.0
RUN cd /tmp \
   && curl -L -O -k https://www-us.apache.org/dist/apr/apr-${APR_VERSION}.tar.gz  \
   && tar -xzf apr-${APR_VERSION}.tar.gz \
   && cd apr-${APR_VERSION} \
   && ./configure --prefix=/usr/local --enable-threads --enable-posix-shm \
        --enable-allocator-guard-pages --enable-pool-concurrency-check --enable-other-child  \
   && make clean > /dev/null 2>&1 \
   && make > /dev/null 2>&1 \
   && make install \
   && cd /tmp \
   && rm -rf apr-${APR_VERSION}.tar.gz apr-${APR_VERSION}

RUN cd /tmp \
   && git clone --depth=1 https://github.com/libexpat/libexpat.git  \
   && cd libexpat/expat  \
   && ./buildconf.sh > /dev/null 2>&1 \
   && ./configure CPPFLAGS=-DXML_LARGE_SIZE --without-docbook --prefix=/usr/local \
   && make > /dev/null 2>&1 \
   && make install \
   && cd /tmp \
   && rm -rf libexpat

ARG APU_VERSION=1.6.1
RUN cd /tmp \
   && curl -L -O -k https://www-us.apache.org/dist//apr/apr-util-${APU_VERSION}.tar.gz  \
   && tar -xzf apr-util-${APU_VERSION}.tar.gz  \
   && cd apr-util-${APU_VERSION} \
   && ./configure --prefix=/usr/local --with-apr=/usr/local --with-expat=/usr/local  \
   && make clean > /dev/null 2>&1  \
   && make > /dev/null 2>&1 \
   && make install \
   && cd /tmp \
   && rm -rf apr-util-${APU_VERSION}.tar.gz apr-util-${APU_VERSION}

RUN cd /tmp \
   && GIT_SSL_NO_VERIFY=1 git clone --depth=1 https://gitbox.apache.org/repos/asf/logging-log4cxx.git  \
   && cd logging-log4cxx  \
   && ./autogen.sh \
   && ./configure --prefix=/usr/local --with-apr=/usr/local --with-apr-util=/usr/local \
        --enable-char --enable-wchar_t --with-charset=utf-8 --with-logchar=utf-8  \
   && make clean > /dev/null 2>&1 \
   && make > /dev/null 2>&1 \
   && make install \
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
   && make install \
   && cd /tmp \
   && rm -Rf breakpad

RUN cd /opt \
   && git clone https://chromium.googlesource.com/chromium/tools/depot_tools
ENV  PATH /opt/depot_tools:$PATH

RUN cd /tmp \
    && git clone https://git.videolan.org/git/x264.git \
    && cd x264 \
    && ./configure --prefix=/usr --bit-depth=all --chroma-format=all --enable-pic --enable-shared \
    && make > /dev/null 2>&1 \
    && make install \
    && cd /tmp \
    && rm -rf x264

#RUN cd /tmp \
#    && git clone --depth=1 https://github.com/cisco/openh264.git \
#    && cd openh264 \
#    && make PREFIX=/usr/local\
#    && make install PREFIX=/usr/local \
#    && cd /tmp \
#    && rm -rf openh264

##    && git clone https://github.com/FFmpeg/FFmpeg.git \
#RUN cd /tmp \
#    && curl -L -O -k https://ffmpeg.org/releases/ffmpeg-4.2.tar.xz \
#    && tar -xJf ffmpeg-4.2.tar.xz \
#    && cd ffmpeg-4.2 \
#        ./configure \
#            --prefix=/usr/local \
#            --target-os=linux --pkg-config-flags=--static \
#            --enable-shared \
#            --extra-libs=-lpthread \
#            --enable-gpl -enable-nonfree \
#            --enable-pthreads \
#            --enable-openssl \
#            --disable-debug \
#            --disable-doc \
#            --disable-ffplay \
#            --enable-decoder=h264 \
#            --enable-encoder=ac3 \
#            --enable-encoder=eac3 \
#            --enable-encoder=mp2 \
#            --enable-encoder=mpeg2video \
#    && make \
#    && make install \
#    && cd /tmp  \
#    && rm -rf ffmpeg-4.2 ffmpeg-4.2.tar.xz

# Clone the other GStreamer modules as meson subprojects and build everything in one go.
#RUN cd /tmp \
#    && git clone https://github.com/GStreamer/gst-build.git\
#    && cd gst-build \
#    && meson --prefix=/usr/local -Dtests=disabled -Ddoc=false -Dgtk_doc=disabled build/ \
#    && PYTHONIOENCODING=utf-8 ninja -C build \
#    && PYTHONIOENCODING=utf-8 ninja -C build install
#    && cd /tmp \
#    && rm -rf gst-build


RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get -qq install --assume-yes --no-install-recommends nodejs

ENV Q_MAJOR_VERSION ${Q_MAJOR_VERSION:-5.13}
ENV Q_VERSION ${Q_VERSION:-${Q_MAJOR_VERSION}.0}
ENV QT_SHA_256 0cd82c80287a783bd5db1339b6184803d57517c9450ffe16f505254853f0a41f
ENV QT_MD5 c839aed9d551bdc8411a0a33e5ae46f3

COPY qt-installer-script.qs /tmp

# COPY qt-opensource-linux-x64-${Q_VERSION}.run /tmp
# RUN objdump -p ./qt-opensource-linux-x64-${Q_VERSION}.run | grep NEEDED

RUN cd /tmp \
   && curl -L -O "http://download.qt.io/official_releases/qt/${Q_MAJOR_VERSION}/${Q_VERSION}/qt-opensource-linux-x64-${Q_VERSION}.run" \
   && chmod +x ./qt-installer-script.qs \
   && chmod +x ./qt-opensource-linux-x64-${Q_VERSION}.run \
   && xvfb-run ./qt-opensource-linux-x64-${Q_VERSION}.run --script ./qt-installer-script.qs --platform minimal --verbose > /dev/null 2>&1 \
   && rm -vf ./qt-opensource-linux-x64-${Q_VERSION}.run ./qt-installer-*

ENV QT_INSTALL_DIR=/opt/qt
ENV QTDIR=${QT_INSTALL_DIR}/${Q_VERSION}/gcc_64
ENV CMAKE_PREFIX_PATH=${QT_INSTALL_DIR}/${Q_VERSION}/gcc_64:$CMAKE_PREFIX_PATH
ENV PATH="${QTDIR}/bin/:${QT_INSTALL_DIR}/Tools/QtCreator/bin:${PATH}"
# ENV LD_LIBRARY_PATH=$QT_BASE_DIR/lib/x86_64-linux-gnu:$QT_BASE_DIR/lib:$LD_LIBRARY_PATH
# ENV PKG_CONFIG_PATH=$QT_BASE_DIR/lib/pkgconfig:$PKG_CONFIG_PATH

RUN cd /tmp \
    && curl -L -O -k https://freefr.dl.sourceforge.net/project/qwt/qwt/6.1.4/qwt-6.1.4.tar.bz2 \
    && tar xjvf qwt-6.1.4.tar.bz2 \
    && cd qwt-6.1.4 \
    && qmake qwt.pro \
    && make > /dev/null 2>&1 \
    && make install DESTDIR=/usr/local \
    && cd /tmp \
    && rm -rf qwt-6.1.4.tar.bz2 qwt-6.1.4

RUN cd /tmp \
    && curl -L -O -k https://ftp.gnu.org/gnu/gsl/gsl-2.6.tar.gz \
    && tar -xzf gsl-2.6.tar.gz \
    && cd gsl-2.6 \
    && ./autogen.sh \
    && ./configure --enable-maintainer-mode --prefix=/usr/local \
    && make -j `nproc` > /dev/null 2>&1 \
    && make install \
    && cd /tmp \
    && rm -rf gsl-2.6.tar.gz gsl-2.6

RUN cd /tmp \
   && git clone  --depth=1 https://github.com/eigenteam/eigen-git-mirror.git \
   && cd eigen-git-mirror \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_CXX_FLAGS="-std=c++11" \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install || true \
   && cd /tmp/ \
   && rm -Rf eigen-git-mirror

RUN cd /tmp \
    && git clone --depth=1  https://github.com/ginkgo-project/ginkgo.git \
    && cd ginkgo \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
        -DGINKGO_BUILD_TESTS=OFF -DGINKGO_BUILD_EXAMPLES=OFF \
        -DCMAKE_C_COMPILER=/usr/bin/gcc -DCMAKE_CXX_COMPILER=/usr/bin/g++ \
        -DGINKGO_DEVEL_TOOLS=OFF -DGINKGO_BUILD_REFERENCE=ON \
        -DCMAKE_BUILD_TYPE=Release \
    && cmake --build build --target all --clean-first > /dev/null 2>&1 \
    && cmake --build build --target install \
    && cd /tmp \
    && rm -rf ginkgo

#RUN cd /tmp \
#    && git clone --depth=1  https://github.com/dealii/dealii.git \
#    && cd dealii \
#    && cmake -E make_directory build \
#    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
#        -DCMAKE_BUILD_TYPE=Release \
#    && cmake --build build --target all --clean-first -- -j`nproc` \
#    && cmake --build build --target install \
#    && cd /tmp \
#    && rm -rf dealii
#c++: internal compiler error: Killed (program cc1plus)
#Please submit a full bug report,
#with preprocessed source if appropriate.
#See <file:///usr/share/doc/gcc-7/README.Bugs> for instructions.
#make[2]: *** [source/numerics/CMakeFiles/obj_numerics_release.dir/data_out.cc.o] Error 4
#source/numerics/CMakeFiles/obj_numerics_release.dir/build.make:62: recipe for target 'source/numerics/CMakeFiles/obj_numerics_release.dir/data_out.cc.o' failed
#make[1]: *** [source/numerics/CMakeFiles/obj_numerics_release.dir/all] Error 2
#make[1]: *** Waiting for unfinished jobs....

RUN cd /tmp \
   && git clone  --depth=1 https://github.com/CGAL/cgal.git \
   && cd cgal \
   && cmake -E make_directory cgal-build \
   && cmake -E chdir cgal-build cmake .. -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_CXX_FLAGS="-std=c++14" -DCGAL_HEADER_ONLY=ON \
      -DCMAKE_CXX_FLAGS_RELEASE=-DCGAL_NDEBUG -DWITH_examples=ON \
      -DWITH_demos=ON -DWITH_tests=ON \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
   && cmake --build cgal-build --target all --clean-first -- -j`nproc`> /dev/null 2>&1 \
   && cmake --build cgal-build --target install \
   && cd /tmp/ \
   && rm -Rf cgal

RUN cd /tmp \
   && git clone  --depth=1 git://git.linuxtv.org/v4l-utils.git \
   && cd v4l-utils \
   && autoreconf -vfi \
   && ./configure --prefix=/usr > /dev/null 2>&1 \
   && make > /dev/null 2>&1 \
   && make install \
   && cd /tmp/ \
   && rm -Rf v4l-utils


RUN echo -e '\033[36;1m *******  To avoid RTI license violation.... ******** \033[0m'
RUN echo -e '\033[36;1m *******  Refert to below commented section ******** \033[0m'
RUN echo -e '\033[36;1m *******  to crreate an efficient development environment of.******** \033[0m'
RUN echo -e '\033[36;1m *******  RTI Connext DDS Professional.******** \033[0m'

# ARG RTI_DDS_VERSION=6.0.0

# COPY src/main/resources/docker/amd64/rti/packages/rti_connext_dds-${RTI_DDS_VERSION}-pro-host-x64Linux.run /tmp/
# COPY src/main/resources/docker/amd64/rti/packages/rti_license.dat /opt/rti_connext_dds-${RTI_DDS_VERSION}/
# COPY src/main/resources/docker/amd64/rti/packages/*.rtipkg  /tmp/
# COPY src/main/resources/docker/amd64/rti/packages/*.tar.gz  /tmp/

# RUN [ -z "$CI_DOMAIN" ] \
#     && cd /tmp/ \
#     && chmod +x /tmp/rti_connext_dds-${RTI_DDS_VERSION}-pro-host-x64Linux.run  \
#     && ./rti_connext_dds-${RTI_DDS_VERSION}-pro-host-x64Linux.run  --mode unattended --prefix /opt --disable_copy_examples true \
#     && rm -rvf /tmp/rti_connext_dds-${RTI_DDS_VERSION}-pro-host-x64Linux.run \
#     || :

# ARG AMD_PREFIX=x64Linux3gcc5.4.0
# ENV NDDSHOME=/opt/rti_connext_dds-${RTI_DDS_VERSION}
# ENV PATH="${PATH}:${NDDSHOME}/bin"
# ENV LD_LIBRARY_PATH=/opt/rti_connext_dds-${RTI_DDS_VERSION}/lib/${AMD_PREFIX}

# RUN [ -z "$CI_DOMAIN" ] \
    # && cd /tmp/ \
    # && rtipkginstall -unattended rti_limited_bandwidth_plugins-6.0.0-x64Linux3gcc5.4.0.rtipkg \
    # && rtipkginstall -unattended rti_security_plugins-6.0.0-target-x64Linux3gcc5.4.0.rtipkg \
    # && rtipkginstall -unattended rti_connext_dds-6.0.0-pro-target-x64Linux3gcc5.4.0.rtipkg \
    # && rtipkginstall -unattended rti_tls_support-6.0.0-x64Linux3gcc5.4.0.rtipkg \
    # && rtipkginstall -unattended rti_secure_wan-6.0.0-x64Linux3gcc5.4.0.rtipkg \
    # && rtipkginstall -unattended rti_limited_bandwidth_plugins_host-6.0.0-x64Linux.rtipkg \
    # && rtipkginstall -unattended rti_web_integration_service-6.0.0-x64Linux.rtipkg \
    # && rtipkginstall -unattended rti_security_plugins-6.0.0-host-x64Linux.rtipkg \
    # && rtipkginstall -unattended rti_database_integration-6.0.0-x64Linux.rtipkg \
    # && rtipkginstall -unattended rti_tls_host_support-6.0.0-x64Linux.rtipkg \
    # && rtipkginstall -unattended rti_connext_dds_micro-3.0.0-Windows.rtipkg \
    # && rtipkginstall -unattended openssl-1.0.2o-6.0.0-host-x64Linux.rtipkg \
    # && rtipkginstall -unattended rti_secure_wan_host-6.0.0-x64Linux.rtipkg \
    # && rtipkginstall -unattended rti_queuing_service-6.0.0-x64Linux.rtipkg \
    # && rtipkginstall -unattended rti_connext_dds_micro-3.0.0-Unix.rtipkg \
    # && rtipkginstall -unattended rti_limited_bandwidth_plugins-6.0.0-x64Linux4gcc7.3.0.rtipkg \
    # && rtipkginstall -unattended rti_security_plugins-6.0.0-target-x64Linux4gcc7.3.0.rtipkg \
    # && rtipkginstall -unattended rti_connext_dds-6.0.0-pro-target-x64Linux4gcc7.3.0.rtipkg \
    # && rtipkginstall -unattended rti_tls_support-6.0.0-x64Linux4gcc7.3.0.rtipkg \
    # && rtipkginstall -unattended rti_secure_wan-6.0.0-x64Linux4gcc7.3.0.rtipkg \
    # && rtipkginstall -unattended rti_security_plugins-6.0.0-target-armv8Linux4.4gcc5.4.0.rtipkg \
    # && rtipkginstall -unattended rti_connext_dds-6.0.0-pro-target-armv8Linux4.4gcc5.4.0.rtipkg \
    # && rtipkginstall -unattended rti_tls_support-6.0.0-armv8Linux4.4gcc5.4.0.rtipkg \
    # && rm -rvf /tmp/*.rtipkg \
    # || :

# RUN [ -z "$CI_DOMAIN" ] \
    # && cd /tmp/ \
    # && mkdir -pv /opt/rti_connext_openssl/{target-x64Linux3gcc5.4.0,target-x64Linux4gcc7.3.0,target-armv8Linux4.4gcc5.4.0} \
    # && mkdir -pv /opt/rti_connext_openssl/target-x64Linux3gcc5.4.0 \
    # && mkdir -pv /opt/rti_connext_openssl/target-x64Linux4gcc7.3.0 \
    # && mkdir -pv /opt/rti_connext_openssl/target-armv8Linux4.4gcc5.4.0 \
    # && tar -zvxf openssl-1.0.2o-target-armv8Linux4.4gcc5.4.0.tar.gz -C /opt/rti_connext_openssl/target-armv8Linux4.4gcc5.4.0 --strip-components=1 \
    # && tar -zvxf openssl-1.0.2o-target-x64Linux4gcc7.3.0.tar.gz -C /opt/rti_connext_openssl/target-x64Linux4gcc7.3.0 --strip-components=1 \
    # && tar -zvxf openssl-1.0.2o-target-x64Linux3gcc5.4.0.tar.gz -C /opt/rti_connext_openssl/target-x64Linux3gcc5.4.0 --strip-components=1 \
    # && rm -rvf /tmp/*.tar.gz \
    # || :

RUN adduser --system --home /home/developer --shell /bin/bash --gecos GECOS \
    --group --disabled-password developer
USER developer
WORKDIR /home/developer

# ENTRYPOINT rtilauncher
# ENTRYPOINT ["/opt/rti_connext_dds-6.0.0/bin/rtipersistenceservice"]
# CMD ["-cfgFile","/config.xml","-cfgName","gets_persistence"]

CMD ["/bin/bash"]

