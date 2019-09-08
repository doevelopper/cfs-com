# %W% %G% %U%
#        cfs-com/src/main/resources/docker/aarch64/common/Dockerfile
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

ARG BASE_IMAGE=docker.io/doevelopper/cfs-com-dind:0.0.1
FROM $BASE_IMAGE

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

ENV AARCH64_DESTDIR /opt/aarch64

RUN apt-get -o Acquire::Check-Valid-Until="false" update --assume-yes \
    && apt-get install --assume-yes --no-install-recommends libtool apt-transport-https ca-certificates autotools-dev\
        crossbuild-essential-arm64
        git xz-utils unzip wget curl openssh-server  openssh-client  automake \
        bison flex build-essential gawk libgcrypt20-dev libcrypto++-dev vim \
        python-pip python3-pip python-dev python3-dev python-wheel cython cython3 python3-wheel \
        perl-base perl-modules zlib1g-dev \
        libxml2-dev libxml2-utils python3-setuptools python-setuptools \
        libgnutls28-dev libcurl4-gnutls-dev libgnutls-openssl27 \
        mesa-common-dev libglu1-mesa-dev libpcap-dev \
        libfontconfig libldap2-dev libldap-2.4-2  libmysql++-dev \
        unixodbc-dev libgdbm-dev libodb-pgsql-dev libcrossguid-dev  uuid-dev libossp-uuid-dev \
        libghc-uuid-dev libghc-uuid-types-dev ruby ruby-dev libelf-dev  elfutils libelf1 \
        libpulse-dev  make nfs-common  xvfb  xauth xterm iputils-ping  libswt-gtk-3-java tmux vim-nox \
    && apt-get clean --assume-yes  \
    && apt-get --assume-yes --quiet clean \
    && apt-get --assume-yes --quiet autoremove \
    && rm -rvf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/* \
    && rm -rf /usr/share/man/

ARG MAKEFLAGS

ENV CMAKE_MAJOR_VERSION ${CMAKE_MAJOR_VERSION:-3.15}
ENV CMAKE_VERSION ${CMAKE_VERSION:-${CMAKE_MAJOR_VERSION}.2}
RUN cd /tmp \
   && curl -L -O -k https://cmake.org/files/v${CMAKE_MAJOR_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
   && tar -xzf cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz > /dev/null 2>&1 \
   && rm cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
   && mv cmake-${CMAKE_VERSION}-Linux-x86_64 /opt/cmake

RUN  cd /tmp \
   && curl -L -O -k  https://github.com/ninja-build/ninja/releases/download/v1.9.0/ninja-linux.zip\
   && unzip ninja-linux.zip > /dev/null 2>&1 \
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

ENV GRADLE_VERSION ${GRADLE_VERSION:-5.5.1}
RUN cd /tmp \
   && curl -L -O -k https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip \
   && mkdir -pv /opt/gradle \
   && unzip gradle-${GRADLE_VERSION}-bin.zip > /dev/null 2>&1 \
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
   && ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh > /dev/null 2>&1 \
   && rm -f ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh

RUN pip install -q --no-cache-dir conan \
   && pip install --upgrade conan_package_tools

ARG TOOLCHAIN_VERSION=8.3-2019.03

RUN cd /tmp \
	&& wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-a/${TOOLCHAIN_VERSION}/gcc-arm-8.2-2019.01-x86_64-aarch64-linux-gnu.tar.xz \
	&& tar xfj gcc-arm-${TOOLCHAIN_VERSION}-x86_64-aarch64-linux-gnu.tar.xz > /dev/null \
	&& mv --verbose gcc-arm-${TOOLCHAIN_VERSION}-x86_64-aarch64-linux-gnu /opt/ \
	&& rm -vf gcc-arm-${TOOLCHAIN_VERSION}-x86_64-aarch64-linux-gnu.tar.xz

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
    && cmake --build build --target all --clean-first \
    && cmake --build build --target install \
    && cd /tmp \
    && rm -rvf uncrustify

RUN cd /tmp \
    && git clone --depth=1 https://github.com/danmar/cppcheck.git \
    && cd cppcheck \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
    && cmake --build build --target all --clean-first  \
    && cmake --build build --target install \
    && cp --recursive --verbose cfg  /usr/local/bin || true \
    && cd /tmp \
    && rm -rvf cppcheck

RUN cd /tmp \
    && git clone --depth=1 https://github.com/doxygen/doxygen.git  \
    && cd doxygen \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
    && cmake --build build --target all --clean-first  \
    && cmake --build build --target install \
    && cd /tmp \
    && rm -rvf doxygen

RUN cd /tmp \
    && git clone --depth=1 https://github.com/google/googletest.git \
    && cd googletest \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake ..  \
        -DCMAKE_TOOLCHAIN_FILE=${BUILD_ROOT}/src/main/resources/cmake/toolChains/arm64v8-toolchain.cmake
        CXX=aarch64-linux-gnu-g++ \
        CC=aarch64-linux-gnu-gcc \
        CXX_FLAGS="${CXX_FLAGS} -fPIE -fPIC" \
        -DCMAKE_INSTALL_PREFIX=${AARCH64_DESTDIR} \
    && cmake --build build --target all --clean-first  \
    && cmake --build build --target install \
    && cd /tmp \
    && rm -rvf googletest

RUN cd /tmp \
    && git clone --depth=1 https://github.com/google/benchmark.git \
    && cd benchmark \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. \
        CXX=aarch64-linux-gnu-g++ \
        CC=aarch64-linux-gnu-gcc \
    -DCMAKE_INSTALL_PREFIX=${AARCH64_DESTDIR} \
    && cmake --build build --target all --clean-first  \
    && cmake --build build --target install \
    && cd /tmp \
    && rm -rvf benchmark

RUN cd /tmp \
    && curl -L -O -k https://dl.bintray.com/boostorg/release/1.69.0/source/boost_1_69_0.tar.gz \
    && tar xfz boost_1_69_0.tar.gz > /dev/null \
    && cd boost_1_69_0 \
    && ./bootstrap.sh --prefix=${AARCH64_DESTDIR} \
    && ./b2 --help \
    && ./b2 toolset=gcc-arm link=static cxxflags=-fPIC threading=multi variant=release address-model=64 -j `nproc` \
    && ./b2 install \
    && cd /tmp \
    && rm -rvf boost_1_69_0 boost_1_69_0.tar.gz

#sml requires GCC >= 6.0.0
RUN cd /tmp \
    && git clone --depth=1 https://github.com/boost-experimental/sml.git \
    && cd sml \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=${AARCH64_DESTDIR} \
    && cmake --build build --target all --clean-first  \
    && cmake --build build --target install \
    && cd /tmp \
    && rm -rvf sml

RUN cd /tmp \
   && git clone --depth=1 --recurse-submodules https://github.com/cucumber/cucumber-cpp.git \
   && cd cucumber-cpp \
   && gem install bundler -v 1.17.3 \
   && bundle install \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake -DCUKE_ENABLE_EXAMPLES=off -DCMAKE_CXX_FLAGS=-std=c++11 -DCMAKE_INSTALL_PREFIX=${AARCH64_DESTDIR} .. \
   && cmake --build build --target all --clean-first \
   && cmake --build build --target install \
   && cd /tmp \
   && rm -rvf cucumber-cpp

RUN cd /tmp \
   && git clone --depth=1 https://github.com/google/double-conversion.git \
   && cd double-conversion \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=${AARCH64_DESTDIR} \
   && cmake --build build --target all --clean-first -- -j `nproc` \
   && cmake --build build --target install \
   && cd /tmp \
   && rm -rvf double-conversion

#RUN cd /tmp \
#   && git clone --depth=1 https://github.com/google/cctz.git \
#   && cd cctz \
#   && cmake -E make_directory build \
#   && cmake -E chdir build cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_INSTALL_PREFIX=/usr/local \
#   && cmake --build build --target all --config Release --clean-first \
#   && ctest \
#   && cmake --build build --config Release --target install \
#   && cd /tmp \
#   && rm -rvf cctz

RUN cd /tmp \
   && git clone --depth=1 https://github.com/google/capture-thread.git \
   && cd capture-thread \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=${AARCH64_DESTDIR} \
   && cmake --build build --target all --clean-first \
   && cmake --build build --target install \
   && cd /tmp \
   && rm -rvf capture-thread

ARG BAZEL_VERSION
ENV BAZEL_VERSION ${BAZEL_VERSION:-0.23.2}
RUN cd /tmp \
    && curl -L -O -k https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh \
    && chmod +x bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh  \
    && ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh \
    && rm -f ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh \
    && bazel version

RUN cd /tmp \
   && git clone --depth=1 https://github.com/google/statechart.git \
#   && cd statechart
#   && bazel build //statechart/... \
#   && bazel test //statechart/... \
#   && bazel run //statechart/example:microwave_example_main -- --alsologtostderr \
   && cd /tmp
#   && rm -rvf statechart

RUN cd /tmp \
#    && GIT_SSL_NO_VERIFY=1 git clone --depth=1 -b OpenSSL_1_0_2-stable https://github.com/openssl/openssl.git  openssl \
    && GIT_SSL_NO_VERIFY=1 git clone --depth=1 --recurse-submodules https://github.com/openssl/openssl.git  openssl \
    && cd openssl \
    && ./config --prefix=${AARCH64_DESTDIR shared --cross-compile-prefix=arm-linux-gnueabihf- linux-armv4  \
    && make  -j `nproc` \
    && make install \
    && cd /tmp \
    && rm -rvf openssl

RUN cd /tmp \
    #&& ./configure --enable-samples --with-openssl=/usr --with-zlib=/usr --prefix=/usr/ \
    && git clone --depth=1 https://github.com/protocolbuffers/protobuf.git \
    && cd protobuf \
    && ./autogen.sh \
    && ./configure --prefix=${AARCH64_DESTDIR} \
    && make clean && make -j `nproc` && make install \
    && cd /tmp \
    && rm -rf protobuf

ENV PROTOBUF_HOME /usr

RUN cd /tmp && curl -L -O -k http://www-us.apache.org/dist//xerces/c/3/sources/xerces-c-3.2.2.tar.gz \
   && tar -xvzf xerces-c-3.2.2.tar.gz  > /dev/null \
   && cd xerces-c-3.2.2/ \
   && ./configure --prefix=${AARCH64_DESTDIR} \
           --enable-static --enable-shared --enable-netaccessor-socket \
           --enable-transcoder-gnuiconv --enable-transcoder-iconv \
           --enable-msgloader-inmemory --enable-xmlch-uint16_t --enable-xmlch-char16_t \
   && make clean && make -j `nproc` && make install \
   && cd /tmp \
   && rm xerces-c-3.2.2.tar.gz \
   && rm -rf xerces-c-3.2.2/

RUN cd /home \
    && curl -L -O -k https://www-us.apache.org/dist/apr/apr-1.6.5.tar.gz  \
    && tar -xvzf apr-1.6.5.tar.gz > /dev/null  \
    && cd apr-1.6.5 \
    && ./configure --prefix=${AARCH64_DESTDIR} --enable-threads --enable-posix-shm \
        --enable-allocator-guard-pages --enable-pool-concurrency-check --enable-other-child \
    && make clean && make && make install  \
    && cd /home \
    && rm -rvf apr-1.6.5.tar.gz apr-1.6.5

RUN cd /home \
    && git clone --depth=1 https://github.com/libexpat/libexpat.git  \
    && cd libexpat/expat  \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=${AARCH64_DESTDIR} \
    && cmake --build build --target all --clean-first  \
    && cmake --build build --target install \
    && cd /home \
    && rm -rvf libexpat

RUN cd /home \
    && curl -L -O -k https://www-us.apache.org/dist//apr/apr-util-1.6.1.tar.gz  \
    && tar -xvzf apr-util-1.6.1.tar.gz > /dev/null  \
    && cd apr-util-1.6.1 \
    && ./configure --prefix=${AARCH64_DESTDIR} --with-apr=${AARCH64_DESTDIR} --with-expat=${AARCH64_DESTDIR} \
    && make clean && make && make install  \
    && cd /home \
    && rm -rvf apr-util-1.6.1.tar.gz apr-util-1.6.1

RUN cd /home \
    && GIT_SSL_NO_VERIFY=1 git clone --depth=1 https://gitbox.apache.org/repos/asf/logging-log4cxx.git  \
    && cd logging-log4cxx  \
    && ./autogen.sh \
    && ./configure --prefix=${AARCH64_DESTDIR} --with-apr=${AARCH64_DESTDIR} --with-apr-util=${AARCH64_DESTDIR} \
        --enable-char --enable-wchar_t --with-charset=utf-8 --with-logchar=utf-8 \
    && make clean && make && make install  \
    && cd /home \
    && rm -rvf logging-log4cxx

ARG ACCOUNT=happyman
RUN useradd -ms /bin/bash $ACCOUNT
RUN chown -R $ACCOUNT:$ACCOUNT /home/$ACCOUNT
USER $ACCOUNT
WORKDIR /home/$ACCOUNT
CMD ["/bin/bash"]

