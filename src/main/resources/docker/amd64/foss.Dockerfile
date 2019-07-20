# ARG BASE_IMAGE=amd64/ubuntu:16.04
# FROM $BASE_IMAGE
FROM amd64/ubuntu:18.10
LABEL description="Env for developping distributed c++ application"

ARG PMC="Adrien H."

MAINTAINER $PMC

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

ARG IMAGE_VERSION
ENV IMAGE_VERSION ${IMAGE_VERSION:-0.0.1}

RUN apt-get -o Acquire::Check-Valid-Until="false" update --assume-yes \
    && apt-get install --assume-yes --no-install-recommends libtool apt-transport-https ca-certificates autotools-dev\
        git xz-utils unzip wget curl openssh-server  openssh-client  automake texinfo texi2html \
        bison flex build-essential gawk libgcrypt20-dev libcrypto++-dev \
        emacs vim tmux vim-nox texinfo \
        tree locate libxkbfile1 \
#        python-pip  python-dev python-wheel cython \
        libnotify4 libnss3 gnupg libsecret-1-0 libsecret-1-dev libxss1 libxss-dev \
        python3-pip python3-dev cython3 python3-wheel python3-setuptools \
        perl-base perl-modules zlib1g-dev \
        libxml2-dev libxml2-utils htop  \
        libgnutls28-dev libcurl4-gnutls-dev libgnutls-openssl27 \
        mesa-common-dev libglu1-mesa-dev libpcap-dev \
        libfontconfig libldap2-dev libldap-2.4-2  libmysql++-dev \
        unixodbc-dev libgdbm-dev libodb-pgsql-dev libcrossguid-dev  uuid-dev libossp-uuid-dev \
        libghc-uuid-dev libghc-uuid-types-dev ruby ruby-dev libelf-dev  elfutils libelf1 \
        libpulse-dev  make nfs-common  xvfb  xauth xterm iputils-ping  libswt-gtk-3-java  \
        x11-xserver-utils x11-apps dbus gpg rxvt-unicode-256color iputils-ping \
        libgtk2.0-0 libcanberra-gtk-module valgrind \
        mscgen graphviz \
    && apt-get clean --assume-yes  \
    && apt-get --assume-yes --quiet clean \
    && apt-get --assume-yes --quiet autoremove \
    && rm -rvf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/* \
    && rm -rf /usr/share/man/


RUN cd /tmp \
    && wget http://ftp.gnu.org/gnu/gdb/gdb-8.3.tar.gz \
    && tar -xvvf gdb-8.3.tar.gz \
    && cd gdb-8.3 \
    && ./configure \
    && make \
    && make install \
    && cd /tmp \
    && rm -rf gdb-8.3.tar.gz gdb-8.3

ENV CMAKE_MAJOR_VERSION ${CMAKE_MAJOR_VERSION:-3.15}
ENV CMAKE_VERSION ${CMAKE_VERSION:-${CMAKE_MAJOR_VERSION}.0}

RUN cd /tmp \
    && curl -L -O -k https://cmake.org/files/v${CMAKE_MAJOR_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
    && tar -xvf cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz > /dev/null \
    && rm -v cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
    && mv -v cmake-${CMAKE_VERSION}-Linux-x86_64 /opt/cmake

#RUN  cd /tmp \
#    && wget --no-cookies --no-check-certificate \
#       --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie"\
#       "https://download.oracle.com/otn-pub/java/jdk/8u212-b10/59066701cf1a433da9770636fbc4c9aa/jdk-8u212-linux-x64.tar.gz" \
#    && tar -xvzf jdk-8u212-linux-x64.tar.gz -C /opt/ \
#    && rm -v jdk-8u212-linux-x64.tar.gz

COPY src/main/resources/docker/jdk-8u212-linux-x64.tar.gz /tmp
RUN  cd /tmp \
    && tar -xvzf jdk-8u212-linux-x64.tar.gz -C /opt/ \
    && rm -v jdk-8u212-linux-x64.tar.gz

ENV MVN_VERSION ${MVN_VERSION:-3.6.1}
RUN cd /tmp \
    &&  wget --no-check-certificate \
    https://www-eu.apache.org/dist/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz \
    && tar -xvzf apache-maven-${MVN_VERSION}-bin.tar.gz \
    && mv apache-maven-${MVN_VERSION}/ /opt/apache-maven \
    && rm -v apache-maven-${MVN_VERSION}-bin.tar.gz

ENV GRADLE_VERSION ${GRADLE_VERSION:-5.5.1}

RUN cd /tmp \
    && curl -L -O -k https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip \
    && mkdir -pv /opt/gradle \
#    && unzip -d /opt/gradle gradle-${GRADLE_VERSION}-bin.zip \
    && unzip gradle-${GRADLE_VERSION}-bin.zip \
    && mv -v gradle-${GRADLE_VERSION}  /opt/gradle/ \
    && rm -vf gradle-${GRADLE_VERSION}-bin.zip

ENV JAVA_HOME /opt/jdk1.8.0_212
ENV JRE_HOME /opt/jdk1.8.0_212/jre
ENV M2_HOME /opt/apache-maven/
ENV M2 $M2_HOME/bin
ENV MAVEN_OPTS "-Dstyle.info=bold,green -Dstyle.project=bold,magenta -Dstyle.warning=bold,yellow \
        -Dstyle.mojo=bold,cyan -Xmx1048m -Xms256m -XX:MaxPermSize=312M"

ENV PATH $PATH:/opt/apache-maven/bin/:/opt/jdk1.8.0_212/bin:/opt/jdk1.8.0_212/jre/bin:/opt/cmake/bin
ENV PATH $PATH:/opt/gradle/gradle-${GRADLE_VERSION}/bin

ARG BAZEL_VERSION
ENV BAZEL_VERSION ${BAZEL_VERSION:-0.28.1}
RUN cd /tmp \
    && curl -L -O -k https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh \
    && chmod +x bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh  \
    && ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh \
    && rm -f ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh


RUN cmake --version \
    && make --version \
    && gcc --version \
    && java -version \
    && mvn --version \
    && gradle -v \
    && bazel version

RUN cd /tmp \
    && GIT_SSL_NO_VERIFY=1 git clone --depth=1 https://github.com/conan-io/conan.git \
    && cd conan  \
    && pip3 install --upgrade pip \
    && pip install -r conans/requirements.txt

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
    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
    && cmake --build build --target all --clean-first  \
    && cmake --build build --target install \
    && cd /tmp \
    && rm -rvf googletest

RUN cd /tmp \
    && git clone --depth=1 https://github.com/google/benchmark.git \
    && cd benchmark \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DBENCHMARK_ENABLE_TESTING=OFF -DCMAKE_INSTALL_PREFIX=/usr/local \
    && cmake --build build --target all --clean-first  \
    && cmake --build build --target install \
    && cd /tmp \
    && rm -rvf benchmark

RUN pip install cmakedoc

RUN cd /tmp \
    && git clone --depth=1 https://github.com/jeaye/stdman.git \
    && cd stdman \
    && ./configure --prefix=/usr \
    && make install \
    && cd /tmp \
    && rm -Rvf stdman

ENV MANPATH=/usr/local/man:/usr/local/share/man:/usr/share/man:/usr/man

ARG BOOST_VERSION_MAJ=1
ARG BOOST_VERSION_MIN=69
ARG BOOST_VERSION_PATCH=0
ARG BOOST_VERSION=1.69.0
ARG BOOST_RELEASE=${BOOST_VERSION_MAJ}_${BOOST_VERSION_MIN}_${BOOST_VERSION_PATCH}


RUN cd /tmp \
    && curl -L -O -k https://dl.bintray.com/boostorg/release/${BOOST_VERSION}/source/boost_${BOOST_RELEASE}.tar.gz \
    && tar xfz boost_${BOOST_RELEASE}.tar.gz > /dev/null \
    && cd boost_${BOOST_RELEASE} \
    && ./bootstrap.sh --prefix=/usr/ --with-python=python3 \
    && ./b2 --help \
    && ./b2 link=shared threading=multi variant=release address-model=64 -j `nproc` \
    && ./b2 install --prefix=/usr/ \
    && cd /tmp \
    && rm -rvf boost_${BOOST_RELEASE} boost_${BOOST_RELEASE}.tar.gz

#sml requires GCC >= 6.0.0
RUN cd /tmp \
    && git clone --depth=1 https://github.com/boost-experimental/sml.git \
    && cd sml \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/ \
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
   && cmake -E chdir build cmake -DCUKE_ENABLE_EXAMPLES=off -DCMAKE_CXX_FLAGS=-std=c++11 -DCMAKE_INSTALL_PREFIX=/usr/local .. \
   && cmake --build build --target all --clean-first \
   && cmake --build build --target install \
   && cd /tmp \
   && rm -rvf cucumber-cpp

RUN cd /tmp \
   && git clone --depth=1 https://github.com/google/double-conversion.git \
   && cd double-conversion \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
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
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
   && cmake --build build --target all --clean-first \
   && cmake --build build --target install \
   && cd /tmp \
   && rm -rvf capture-thread

#RUN cd /tmp \
#   && git clone --depth=1 https://github.com/google/statechart.git \
#   && cd statechart \
#   && bazel build //statechart/... \
#   && bazel test //statechart/... \
#   && bazel run //statechart/example:microwave_example_main -- --alsologtostderr \
#   && cd /tmp
#   && rm -rvf statechart

RUN cd /tmp \
#    && GIT_SSL_NO_VERIFY=1 git clone --depth=1 -b OpenSSL_1_0_2-stable https://github.com/openssl/openssl.git  openssl \
    && GIT_SSL_NO_VERIFY=1 git clone --depth=1 --recurse-submodules https://github.com/openssl/openssl.git  openssl \
    && cd openssl \
    && ./config --prefix=/usr shared  \
    && make -j `nproc` \
    && make install \
    && cd /tmp \
    && rm -rvf openssl

RUN cd /tmp \
    #&& ./configure --enable-samples --with-openssl=/usr --with-zlib=/usr --prefix=/usr/ \
    && git clone --depth=1 https://github.com/protocolbuffers/protobuf.git \
    && cd protobuf \
    && ./autogen.sh \
    && ./configure --prefix=/usr \
    && make clean && make -j `nproc` && make install \
    && cd /tmp \
    && rm -rf protobuf

ENV PROTOBUF_HOME /usr

RUN cd /tmp && curl -L -O -k http://www-us.apache.org/dist//xerces/c/3/sources/xerces-c-3.2.2.tar.gz \
   && tar -xvzf xerces-c-3.2.2.tar.gz  > /dev/null \
   && cd xerces-c-3.2.2/ \
   && ./configure --prefix=/usr/local \
           --enable-static --enable-shared --enable-netaccessor-socket \
           --enable-transcoder-gnuiconv --enable-transcoder-iconv \
           --enable-msgloader-inmemory --enable-xmlch-uint16_t --enable-xmlch-char16_t \
   && make clean && make -j `nproc` && make install \
   && cd /tmp \
   && rm xerces-c-3.2.2.tar.gz \
   && rm -rf xerces-c-3.2.2/

RUN cd /tmp \
    && curl -L -O -k https://www-us.apache.org/dist/apr/apr-1.6.5.tar.gz  \
    && tar -xvzf apr-1.6.5.tar.gz > /dev/null  \
    && cd apr-1.6.5 \
    && ./configure --prefix=/usr/ --enable-threads --enable-posix-shm \
        --enable-allocator-guard-pages --enable-pool-concurrency-check --enable-other-child \
    && make clean && make && make install  \
    && cd /tmp \
    && rm -rvf apr-1.6.5.tar.gz apr-1.6.5

RUN cd /tmp \
    && git clone --depth=1 https://github.com/libexpat/libexpat.git  \
    && cd libexpat/expat  \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/ \
    && cmake --build build --target all --clean-first  \
    && cmake --build build --target install \
    && cd /tmp \
    && rm -rvf libexpat

RUN cd /tmp \
    && curl -L -O -k https://www-us.apache.org/dist//apr/apr-util-1.6.1.tar.gz  \
    && tar -xvzf apr-util-1.6.1.tar.gz > /dev/null  \
    && cd apr-util-1.6.1 \
    && ./configure --prefix=/usr/ --with-apr=/usr/ --with-expat=/usr/ \
    && make clean && make && make install \
    && cd /tmp \
    && rm -rvf apr-util-1.6.1.tar.gz apr-util-1.6.1

RUN cd /tmp \
    && GIT_SSL_NO_VERIFY=1 git clone --depth=1 https://gitbox.apache.org/repos/asf/logging-log4cxx.git  \
    && cd logging-log4cxx \
    && ./autogen.sh \
    && ./configure --prefix=/usr/ --with-apr=/usr/ --with-apr-util=/usr/ \
        --enable-char --enable-wchar_t --with-charset=utf-8 --with-logchar=utf-8 \
    && make clean && make && make install  \
    && cd /tmp \
    && rm -rvf logging-log4cxx

RUN cd /tmp \
	&& git clone --depth=1 https://github.com/catchorg/Catch2.git \
	&& cd Catch2 \
	&& cmake -E make_directory build \
	&& cmake -E chdir build cmake .. -DUSE_CPP14=1 -DCMAKE_INSTALL_PREFIX=/usr/local \
	&& cmake --build build --target all --clean-first \
	&& cmake --build build --target install || true \
	&& cd /tmp \
	&& rm -Rf Catch2

#RUN cd /tmp \
#	&& git clone --depth=1 https://github.com/cpp-testing/GUnit.git \
#	&& cd GUnit \
#	&& cmake -E make_directory build \
#	&& cmake -E chdir build cmake ..-DCMAKE_INSTALL_PREFIX=/usr/local \
#	&& cmake --build build --target all --clean-first \
#	&& cmake --build build --target install || true \
#	&& cd /tmp \
#	&& rm -Rf GUnit

RUN cd /tmp \
	&& git clone --depth=1 https://github.com/google/breakpad.git \
	&& cd breakpad \
	&& git clone https://chromium.googlesource.com/linux-syscall-support src/third_party/lss \
	&& ./configure --prefix=/usr/local \
	&& make -j `nproc` \
	&& make install \
	&& cd /tmp \
	&& rm -Rf breakpad

RUN cd /tmp \
  && curl -o vscode-amd64.deb -L -O -k   https://go.microsoft.com/fwlink/?LinkID=760868 \
  && dpkg -i vscode-amd64.deb \
  &&  rm vscode-amd64.deb

#ADD ./src/main/resources/docker/amd64/vscode-ext.sh /tmp/

#RUN cd /tmp \
#    && chmod +x vscode-ext.sh\ 
#    && ./vscode-ext.sh \ 
#    && rm -vf vscode-ext.sh

ARG ACCOUNT=developer
RUN useradd -ms /bin/bash $ACCOUNT
RUN chown -R $ACCOUNT:$ACCOUNT /home/$ACCOUNT
USER $ACCOUNT
WORKDIR /home/$ACCOUNT
CMD ["/bin/bash"]


# docker run --rm -ti -e HOST_PERMS="$(id -u):$(id -g)" --volume "${HOME}/.conan:/home/happyman/.conan" --volume ${HOME}/.vimrc:/home/happyman/.vim --volume ${HOME}/.vimrc:/home/happyman/.vimrc --volume ${HOME}/.bashrc:/home/happyman/.bashrc  registry.gear.ge.com/100034251/rti-dds:latest --volume "$PWD:/home/happyman/workspace"

