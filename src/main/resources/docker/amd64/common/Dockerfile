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

#docker build --build-arg PROXY=$HTTP_PROXY
ARG PROXY
ARG MAKEFLAGS
ARG NOPROXY
ARG http_proxy=$PROXY
ARG https_proxy=$PROXY
ARG no_proxy=$NOPROXY
ARG HTTP_PROXY=$PROXY
ARG HTTPS_PROXY=$PROXY
ARG NO_PROXY=$NOPROXY
ARG CMAKE_MAJOR_VERSION=${CMAKE_MAJOR_VERSION:-3.15}
ARG CMAKE_VERSION=${CMAKE_VERSION:-${CMAKE_MAJOR_VERSION}.3}
ARG MVN_VERSION=${MVN_VERSION:-3.6.2}
ARG GRADLE_VERSION=${GRADLE_VERSION:-5.6.2}
ARG BAZEL_VERSION=${BAZEL_VERSION:-0.29.1}
ARG BOOST_VERSION_MAJ=1
ARG BOOST_VERSION_MIN=69
ARG BOOST_VERSION_PATCH=0
ARG BOOST_VERSION=${BOOST_VERSION_MAJ}.${BOOST_VERSION_MIN}.${BOOST_VERSION_PATCH}
ARG BOOST_RELEASE=${BOOST_VERSION_MAJ}_${BOOST_VERSION_MIN}_${BOOST_VERSION_PATCH}
ARG APR_VERSION=1.7.0
ARG APU_VERSION=1.6.1
ARG Q_MAJOR_VERSION=${Q_MAJOR_VERSION:-5.13}
ARG Q_VERSION=${Q_VERSION:-${Q_MAJOR_VERSION}.1}
ARG QT_SHA_256=0cd82c80287a783bd5db1339b6184803d57517c9450ffe16f505254853f0a41f
ARG T_MD5=c839aed9d551bdc8411a0a33e5ae46f3

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
      ruby ruby-dev libjpeg-dev libudev-dev libmpfr-dev \
      libglib2.0-dev libglib2.0-bin libglib2.0-0 \
      xvfb xauth libx11-xcb1 libfontconfig1 libfontconfig1-dev libdbus-1-3 libgl1-mesa-dev \
      libperl-dev perl perl-base perl-modules apt-utils gettext \
      yasm nasm xotcl-dev tcl-expect-dev tcl-dev docbook2x dos2unix \
      libpulse-dev libva-dev libxv-dev libelf-dev elfutils libelf1 \
      libavformat-dev libavutil-dev libdlna-dev libavcodec-dev uvcdynctrl \
      libtsan0-dbg libtsan0 valgrind valgrind-dbg mscgen libgraphviz-dev xdo \
      display-dhammapada fortunes lsb-release libpng-dev libghc-graphviz-dev \
      libcrypto++-dev libgcrypt20-dev libpcap-dev libwiretap-dev bittwist tkpng \
      gnutls-bin ntopng pcaputils python-pcapy python-pypcap tcpick tcpspy libgnutls30 \
      gobject-introspection liborc-0.4-dev liborc-0.4-dev-bin libgudev-1.0-dev libgudev3.0-cil-dev \
      libogg-dev liboggz2-dev python-ogg libisocodes-dev gir1.2-isocodes-1.2 libpng++-dev \
      libtheora-dev libtheora-bin libvorbis-dev python-pyvorbis libogg-vorbis-decoder-perl\
   && apt-get clean --assume-yes  \
   && apt-get --assume-yes --quiet clean \
   && apt-get --assume-yes --quiet autoremove \
   && rm -rvf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/* \
   && rm -rf /usr/share/man/

##setting up the apt so it will run through the proxy
# RUN [ -n "$http_proxy" ] && echo "Acquire::http::proxy \"$http_proxy\";" > /etc/apt/apt.conf; \
    # [ -n "$https_proxy" ] && echo "Acquire::https::proxy \"$https_proxy\";" >> /etc/apt/apt.conf; \
    # [ -f /etc/apt/apt.conf ] && cat /etc/apt/apt.conf; exit 0

# RUN apt-get update

# Set wget proxies
RUN [ -n "$http_proxy" ] && printf "use_proxy=yes\nhttp_proxy=$http_proxy\nhttps_proxy=$https_proxy\nno_proxy=$no_proxy" > /root/.wgetrc; exit 0


RUN cd /tmp \
    && curl -L -O -k https://cmake.org/files/v${CMAKE_MAJOR_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
    && tar -xvf cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz > /dev/null \
    && rm -v cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
    && mv -v cmake-${CMAKE_VERSION}-Linux-x86_64 /opt/cmake

RUN  cd /tmp \
    # && curl -x '${HTTPS_PROXY}' -L -O -k https://github.com/ninja-build/ninja/releases/download/v1.9.0/ninja-linux.zip\
   && curl -L -O -k  https://github.com/ninja-build/ninja/releases/download/v1.9.0/ninja-linux.zip\
   && unzip ninja-linux.zip  \
   && mv ninja /usr/bin/ninja \
   && rm ninja-linux.zip

# COPY [ -f ./jdk-8u212-linux-x64.tar.gz ] && [] jdk-8u212-linux-x64.tar.gz /tmp

RUN  cd /tmp \
#  http://enos.itcollege.ee/~jpoial/allalaadimised/jdk8/jdk-8u212-linux-x64.tar.gz
   && curl -L -O -k https://github.com/frekele/oracle-java/releases/download/8u212-b10/jdk-8u212-linux-x64.tar.gz \
   && tar -xzf jdk-8u212-linux-x64.tar.gz -C /opt/ \
   && rm jdk-8u212-linux-x64.tar.gz

RUN cd /tmp \
   &&  wget --no-check-certificate \
   https://www-eu.apache.org/dist/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz \
   && tar -xzf apache-maven-${MVN_VERSION}-bin.tar.gz > /dev/null 2>&1 \
   && mv apache-maven-${MVN_VERSION}/ /opt/apache-maven \
   && rm -v apache-maven-${MVN_VERSION}-bin.tar.gz

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
   && pip install -U Sphinx \
   && pip3 install cmakedoc \
   && pip install cpp-coveralls \
   && pip install coverxygen \
   && pip install doxygen-junit \
   && pip install gdb-tools

RUN cmake --version \
   && make --version \
   && gcc --version \
   && java -version \
   && mvn --version \
   && gradle -v \
   && bazel version \
   && conan --version || true

RUN cd /tmp \
   && Time="$(date +%s)" \
   && curl -L -O -k http://ftp.gnu.org/gnu/gdb/gdb-8.3.tar.gz \
   && tar -xzf gdb-8.3.tar.gz \
   && cd gdb-8.3 \
   && ./configure --prefix=/usr/local \
   && make > /dev/null 2>&1 \
   && make install \
   && cd /tmp \
   && rm -rf gdb-8.3.tar.gz gdb-8.3 \
   && Time="$(($(date +%s)-Time))" \
   && printf "Build time: %dd %02d:%02d:%02d\n" "$((Time/86400))" "$((Time/3600%24))" "$((Time/60%60))" "$((Time%60))"

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
   && cmake --build build --target install \
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

RUN cd /tmp \
   && curl -L -O -k https://dl.bintray.com/boostorg/release/${BOOST_VERSION}/source/boost_${BOOST_RELEASE}.tar.gz \
   && tar xzf boost_${BOOST_RELEASE}.tar.gz \
   && cd boost_${BOOST_RELEASE} \
   && ./bootstrap.sh --prefix=/usr/local --with-python=python3 \
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
   && curl -L -O -k http://lcamtuf.coredump.cx/afl/releases/afl-2.52b.tgz \
   && tar zxvf afl-2.52b.tgz --one-top-level=american-fuzzy-lop \
   && tar -xvzf afl-2.52b.tgz \
   && cd afl-2.52b \
   && make clean  > /dev/null 2>&1\
   && make > /dev/null 2>&1 \
#   && make DESTDIR=/opt/afl  BINDIR=/opt/afl/bin DATAROOTDIR=/opt/afl/share LIBDIR=/opt/afl/lib install \
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
   && cmake -E chdir build cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=ON -DCMAKE_INSTALL_PREFIX=/usr/local \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
#   - test/cctest/cctest --list | tr -d '<' | xargs test/cctest/cctest \
   && cmake --build build --target install || true \
   && cd /tmp \
   && rm -rf double-conversion

RUN cd /tmp \
#    && GIT_SSL_NO_VERIFY=1 git clone --depth=1 -b OpenSSL_1_0_2-stable https://github.com/openssl/openssl.git  openssl \
   && GIT_SSL_NO_VERIFY=1 git clone --depth=1 --recurse-submodules https://github.com/openssl/openssl.git  openssl \
   && cd openssl \
#    && ./config --prefix=/usr/local shared enable-ec enable-ecdh enable-ecdsa \
   && ./config --prefix=/usr/local shared  \
   && make > /dev/null 2>&1 \
   && make install \
   && cd /tmp \
   && rm -rf openssl

RUN cd /tmp \
   && git clone --depth=1 https://github.com/protocolbuffers/protobuf.git \
   && cd protobuf \
   && ./autogen.sh > /dev/null 2>&1  \
   && ./configure --enable-samples --with-openssl=/usr --with-zlib=/usr --enable-silent-rules --prefix=/usr/local \
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
   && make install > /dev/null 2>&1 \
   && cd /tmp \
   && rm xerces-c-3.2.2.tar.gz \
   && rm -rf xerces-c-3.2.2/

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
   && cmake -E chdir build cmake .. -DEXAMPLES=ON -DCOVERAGE=OFF -DEXTRAS=ON -DCMAKE_CXX_STANDARD=17 \
       -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD_REQUIRED=ON -DCMAKE_CXX_EXTENSIONS=OFF -DCMAKE_INSTALL_PREFIX=/usr/local \
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

COPY qt-installer-script.qs /tmp
#COPY qt-opensource-linux-x64-${Q_VERSION}.run* /tmp
# RUN objdump -p ./qt-opensource-linux-x64-${Q_VERSION}.run | grep NEEDED

#RUN cd /tmp \
#    && if [[ -n $CI_DOMAIN ]]; then \
#            curl -k -L -O "http://download.qt.io/official_releases/qt/${Q_MAJOR_VERSION}/${Q_VERSION}/qt-opensource-linux-x64-${Q_VERSION}.run"; \
#        else \
#            : ; \
#        fi

RUN cd /tmp \
   && curl -k -L -O "http://download.qt.io/official_releases/qt/${Q_MAJOR_VERSION}/${Q_VERSION}/qt-opensource-linux-x64-${Q_VERSION}.run" \
   && chmod +x ./qt-installer-script.qs \
   && chmod +x ./qt-opensource-linux-x64-${Q_VERSION}.run \
   && xvfb-run ./qt-opensource-linux-x64-${Q_VERSION}.run --script ./qt-installer-script.qs --platform minimal --verbose > /dev/null 2>&1 \
   && rm -vf qt-opensource-linux-x64-${Q_VERSION}.run qt-installer-script.qs

ENV QT_INSTALL_DIR=/opt/qt
ENV QTDIR=${QT_INSTALL_DIR}/${Q_VERSION}/gcc_64
ENV PATH="${QTDIR}/bin/:${QT_INSTALL_DIR}/Tools/QtCreator/bin:${PATH}"
ENV PKG_CONFIG_PATH=${QTDIR}/lib/pkgconfig:$PKG_CONFIG_PATH

RUN cd /tmp \
    && git clone https://git.videolan.org/git/x264.git \
    && cd x264 \
    && ./configure --prefix=/usr/local --bit-depth=all --chroma-format=all --enable-pic --enable-shared \
    && make > /dev/null 2>&1 \
    && make install \
    && cd /tmp \
    && rm -rf x264

# RUN cd /tmp \
    # && git clone --depth=1 https://github.com/cisco/openh264.git \
    # && cd openh264 \
    # && make PREFIX=/usr/local\
    # && make install PREFIX=/usr/local \
    # && cd /tmp \
    # && rm -rf openh264

##&& git clone https://github.com/FFmpeg/FFmpeg.git \
# RUN cd /tmp \
    # && curl -L -O -k https://ffmpeg.org/releases/ffmpeg-4.2.tar.xz \
    # && tar -xJf ffmpeg-4.2.tar.xz \
    # && cd ffmpeg-4.2 \
        # ./configure \
            # --prefix=/usr/local \
            # --target-os=linux --pkg-config-flags=--static \
            # --enable-shared \
            # --extra-libs=-lpthread \
            # --enable-gpl -enable-nonfree \
            # --enable-pthreads \
            # --enable-openssl \
            # --disable-debug \
            # --disable-doc \
            # --disable-ffplay \
            # --enable-decoder=h264 \
            # --enable-encoder=ac3 \
            # --enable-encoder=eac3 \
            # --enable-encoder=mp2 \
            # --enable-encoder=mpeg2video \
    # && make \
    # && make install \
    # && cd /tmp  \
    # && rm -rf ffmpeg-4.2 ffmpeg-4.2.tar.xz

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get -qq install --assume-yes --no-install-recommends nodejs

RUN cd /tmp \
    && curl -L -O -k https://freefr.dl.sourceforge.net/project/qwt/qwt/6.1.4/qwt-6.1.4.tar.bz2 \
    && tar xjvf qwt-6.1.4.tar.bz2 \
    && cd qwt-6.1.4 \
    && qmake qwt.pro \
    && make > /dev/null 2>&1 \
    && make install DESTDIR=/usr/local \
    && cd /tmp \
    && rm -rf qwt-6.1.4.tar.bz2 qwt-6.1.4

# Clone the other GStreamer modules as meson subprojects and build everything in one go.
RUN cd /tmp \
   && git clone --depth=1 https://gitlab.freedesktop.org/gstreamer/gst-build.git


# RUN cd /tmp \
    # && cd gst-build \
    # && meson --prefix=/usr/local \
        # -Dpython=enabled -Dlibav=enabled -Dugly=enabled -Dbad=enabled -Ddevtools=enabled \
        # -Dges=enabled -Drtsp_server=enabled -Dvaapi=enabled -Dsharp=disabled \
        # -Dtests=disabled -Ddoc=disabled -Dgtk_doc=disabled build/ \
        # -Dintrospection=disabled -Dexamples=disabled -Dbenchmarks=disabled \
        # -Dcpp_std=c++11 \
        # -Dorc=disabled \
        # -Dgst-python:python=/usr/bin/python3.7 \
        # -Dpygobject=enabled \
        # -Dpygobject:python=/usr/bin/python3.7 \
        # -Dpygobject:pycairo=false \
        # -Dgobject-introspection:python=/usr/bin/python3.7 \
    # && PYTHONIOENCODING=utf-8 ninja -C build \
    # && PYTHONIOENCODING=utf-8 ninja -C build install \
    # && cd /tmp \
    # && rm -rf gst-build

ARG GST_VERSION=1.16.0

# http://www.linuxfromscratch.org/blfs/view/svn/multimedia/gstreamer10.html
RUN cd /tmp \
    && curl -L -O -k https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-${GST_VERSION}.tar.xz \
    && tar xvfJ gstreamer-${GST_VERSION}.tar.xz > /dev/null \
	&& curl -L -O -k http://www.linuxfromscratch.org/patches/blfs/svn/gstreamer-1.16.0-buffer_size_reset_fix-1.patch \
    && cd gstreamer-${GST_VERSION} \
	&& patch -Np1 -i ../gstreamer-1.16.0-buffer_size_reset_fix-1.patch  \
	&& meson  --prefix=/usr/local build/ \
	    -Dbuildtype=release \
		-Dgst_debug=false   \
		-Dgtk_doc=disabled  \
		-Dpackage-origin=http://www.linuxfromscratch.org/blfs/view/svn/ \
		-Dpackage-name="GStreamer 1.16.0 BLFS" \
    && ninja -C build/  > /dev/null 2>&1\
    && ninja -C build/ install \
    && cd /tmp/ \
    && rm -rf gstreamer-*

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
# gst-plugins-base
RUN cd /tmp \
    && curl -L -O -k https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-${GST_VERSION}.tar.xz \
    && tar xvfJ gst-plugins-base-${GST_VERSION}.tar.xz > /dev/null \
    && cd gst-plugins-base-${GST_VERSION} \
	&& meson  --prefix=/usr/local build/ \
	    -Dbuildtype=release \
		-Dgst_debug=false   \
		-Dgtk_doc=disabled  \
		-Dpackage-origin=http://www.linuxfromscratch.org/blfs/view/svn/ \
		-Dpackage-name="GStreamer 1.16.0 BLFS" \
    && ninja -C build/  > /dev/null 2>&1\
    && ninja -C build/ install \
    && cd /tmp/ \
    && rm -rf gst-plugins-good-*

# libnice
RUN cd /tmp \
    && git clone --depth=1  https://github.com/libnice/libnice.git \
    && cd libnice \
    && ./autogen.sh --prefix=/usr/local \
      --with-gstreamer --enable-static --enable-static-plugins \
      --enable-shared --without-gstreamer-0.10 --disable-gtk-doc \
    && make install > /dev/null 2>&1 \
    && cd /tmp/ \
    && rm -rf libnice

# gst-plugins-good
RUN cd /tmp \
    && curl -L -O -k https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-${GST_VERSION}.tar.xz \
    && tar xvfJ gst-plugins-good-${GST_VERSION}.tar.xz > /dev/null \
    && cd gst-plugins-good-${GST_VERSION} \
	&& meson  --prefix=/usr/local build/ \
	    -Dbuildtype=release \
		-Dgst_debug=false   \
		-Dgtk_doc=disabled  \
		-Dpackage-origin=http://www.linuxfromscratch.org/blfs/view/svn/ \
		-Dpackage-name="GStreamer 1.16.0 BLFS" \
    && ninja -C build/  > /dev/null 2>&1\
    && ninja -C build/ install \
    && cd /tmp/ \
    && rm -rf gst-plugins-good-*


# gst-plugins-bad
RUN cd /tmp \
    && curl -L -O -k https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-${GST_VERSION}.tar.xz \
    && tar xvfJ gst-plugins-bad-${GST_VERSION}.tar.xz > /dev/null \
    && cd gst-plugins-bad-${GST_VERSION} \
	&& meson --prefix=/usr/local build/ \
	    -Dbuildtype=release \
		-Dgst_debug=false   \
		-Dgtk_doc=disabled  \
		-Dpackage-origin=http://www.linuxfromscratch.org/blfs/view/svn/ \
		-Dpackage-name="GStreamer 1.16.0 BLFS" \
    && ninja -C build/  > /dev/null 2>&1\
    && ninja -C build/ install \
    && cd /tmp/ \
    && rm -rf gst-plugins-bad-*

# gst-plugins-ugly
RUN cd /tmp \
    && curl -L -O -k https://gstreamer.freedesktop.org/src/gst-plugins-ugly/gst-plugins-ugly-${GST_VERSION}.tar.xz \
    && tar xvfJ gst-plugins-ugly-${GST_VERSION}.tar.xz > /dev/null \
    && cd gst-plugins-ugly-${GST_VERSION} \
	&& meson --prefix=/usr/local build/ \
	    -Dbuildtype=release \
		-Dgst_debug=false   \
		-Dgtk_doc=disabled  \
		-Dpackage-origin=http://www.linuxfromscratch.org/blfs/view/svn/ \
		-Dpackage-name="GStreamer 1.16.0 BLFS" \
    && ninja -C build/  > /dev/null 2>&1\
    && ninja -C build/ install \
    && cd /tmp/ \
    && rm -rf gst-plugins-ugly-*

# gst-libav
RUN cd /tmp \
    && curl -L -O -k https://gstreamer.freedesktop.org/src/gst-libav/gst-libav-${GST_VERSION}.tar.xz \
    && tar xvfJ gst-libav-${GST_VERSION}.tar.xz > /dev/null \
    && cd gst-libav-${GST_VERSION} \
	&& meson --prefix=/usr/local build/ \
	    -Dbuildtype=release \
		-Dgst_debug=false   \
		-Dgtk_doc=disabled  \
		-Dpackage-origin=http://www.linuxfromscratch.org/blfs/view/svn/ \
		-Dpackage-name="GStreamer 1.16.0 BLFS" \
    && ninja -C build/ > /dev/null 2>&1\
    && ninja -C build/ install \
    && cd /tmp/ \
    && rm -rf gst-libav-*

# gst-rtsp-server
RUN cd /tmp \
    && curl -L -O -k https://gstreamer.freedesktop.org/src/gst-rtsp-server/gst-rtsp-server-${GST_VERSION}.tar.xz \
    && tar xvfJ gst-rtsp-server-${GST_VERSION}.tar.xz > /dev/null \
    && cd gst-rtsp-server-${GST_VERSION} \
    && ./configure --prefix=/usr/local --disable-gtk-doc \
    && make > /dev/null 2>&1 \
    && make install  \
    && cd /tmp/ \
    && rm -rf gst-*

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
   && git clone --depth=1 https://github.com/eigenteam/eigen-git-mirror.git \
   && cd eigen-git-mirror \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_CXX_FLAGS="-std=c++11" \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install \
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

#c++: internal compiler error: Killed (program cc1plus)
#Please submit a full bug report,
#with preprocessed source if appropriate.
#See <file:///usr/share/doc/gcc-7/README.Bugs> for instructions.
#make[2]: *** [source/numerics/CMakeFiles/obj_numerics_release.dir/data_out.cc.o] Error 4
#source/numerics/CMakeFiles/obj_numerics_release.dir/build.make:62: recipe for target 'source/numerics/CMakeFiles/obj_numerics_release.dir/data_out.cc.o' failed
#make[1]: *** [source/numerics/CMakeFiles/obj_numerics_release.dir/all] Error 2
#make[1]: *** Waiting for unfinished jobs....
#RUN cd /tmp \
#    && git clone --depth=1  https://github.com/dealii/dealii.git \
#    && cd dealii \
#    && cmake -E make_directory build \
#    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
#        -DCMAKE_BUILD_TYPE=Release \
#    && cmake --build build --target all --clean-first > /dev/null 2>&1 \
#    && cmake --build build --target install > /dev/null 2>&1 \
#    && cd /tmp \
#    && rm -rf dealii

RUN cd /tmp \
   && git clone --depth=1 https://github.com/CGAL/cgal.git \
   && cd cgal \
   && cmake -E make_directory cgal-build \
   && cmake -E chdir cgal-build cmake -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_CXX_FLAGS="-std=c++14" -DCGAL_HEADER_ONLY=OFF \
      -DCMAKE_CXX_FLAGS_RELEASE=-DCGAL_NDEBUG -DWITH_examples=OFF \
      -DWITH_demos=OFF -DWITH_tests=OFF \
      -DCMAKE_INSTALL_PREFIX=/usr/local .. \
   && cmake --build cgal-build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build cgal-build --target install \
   && cd /tmp/ \
   && rm -Rf cgal

RUN cd /tmp \
   && git clone  --depth=1 git://git.linuxtv.org/v4l-utils.git \
   && cd v4l-utils \
   && autoreconf -vfi \
   && ./configure --prefix=/usr/local \
   && make > /dev/null 2>&1 \
   && make install \
   && cd /tmp/ \
   && rm -Rf v4l-utils

RUN cd /tmp \
    && git clone --depth=1 https://github.com/QuantStack/xsimd.git \
    && cd xsimd \
    && cmake -E make_directory xsimd-build \
    && cmake -E chdir xsimd-build cmake -DCMAKE_BUILD_TYPE=Release \
       -DCMAKE_INSTALL_PREFIX=/usr/local .. \
    && cmake --build xsimd-build --target all --clean-first > /dev/null 2>&1 \
    && cmake --build xsimd-build --target install \
    && cd /tmp/ \
    && rm -Rf xsimd


#RUN cd /tmp \
#    && git clone --depth=1 --recurse-submodules  https://github.com/lemire/simdjson.git

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

#RUN set -ex    cut -d: -f1 /etc/group
#RUN set -ex    cut -d: -f1 /etc/passwd
#RUN adduser --system --home /home/developer --shell /bin/bash --gecos GECOS \
#    --group --disabled-password developer
#USER developer
#WORKDIR /home/developer


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
#    && git clone -b $GST_VERSION --depth=1 git://anongit.freedesktop.org/git/gstreamer/gstreamer \
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
#    cmake .. -G "Unix Makefiles"i

