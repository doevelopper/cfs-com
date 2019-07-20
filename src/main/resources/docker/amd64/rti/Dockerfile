# ARG BASE_IMAGE=amd64/ubuntu:16.04 ##registry access issue
# FROM $BASE_IMAGE
FROM amd64/ubuntu:16.04

ARG PMC="Adrien H."

MAINTAINER $PMC

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

ARG IMAGE_VERSION
ENV IMAGE_VERSION ${IMAGE_VERSION:-0.0.1}

RUN apt-get update \
    && apt-get install --assume-yes --no-install-recommends libtool apt-transport-https ca-certificates autotools-dev\
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

ARG CMAKE_MAJOR=3.15
ARG CMAKE_MINOR=0-rc3

RUN curl -L -O -k https://cmake.org/files/v${CMAKE_MAJOR}/cmake-${CMAKE_MAJOR}.${CMAKE_MINOR}-Linux-x86_64.tar.gz \
    && tar -xvf cmake-${CMAKE_MAJOR}.${CMAKE_MINOR}-Linux-x86_64.tar.gz > /dev/null \
    && rm -v cmake-${CMAKE_MAJOR}.${CMAKE_MINOR}-Linux-x86_64.tar.gz \
    && mv -v cmake-${CMAKE_MAJOR}.${CMAKE_MINOR}-Linux-x86_64 /opt/cmake

#RUN  cd /tmp \
#    && wget --no-cookies --no-check-certificate \
#       --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie"\
#       "https://download.oracle.com/otn-pub/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-linux-x64.tar.gz" \
#    && tar -xvzf jdk-8u202-linux-x64.tar.gz -C /opt/ \
#    && rm -v jdk-8u202-linux-x64.tar.gz

COPY src/main/resources/docker/jdk-8u212-linux-x64.tar.gz /tmp
RUN  cd /tmp \
    && tar -xvzf jdk-8u212-linux-x64.tar.gz -C /opt/ \
    && rm -v jdk-8u212-linux-x64.tar.gz

ENV JAVA_HOME /opt/jdk1.8.0_212
ENV JRE_HOME /opt/jdk1.8.0_212/jre

ARG MAVEN_VERSION=3.6.1

RUN cd /tmp \
    &&  wget --no-check-certificate https://www-eu.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && tar -xvzf apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && mv apache-maven-${MAVEN_VERSION}/ /opt/apache-maven \
    && rm -v apache-maven-${MAVEN_VERSION}-bin.tar.gz

ARG GRADLE_VERSION=5.5

RUN cd /tmp \
    && curl -L -O -k https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip \
    && mkdir -pv /opt/gradle \
#    && unzip -d /opt/gradle gradle-5.2.1-bin.zip \
    && unzip gradle-${GRADLE_VERSION}-bin.zip \
    && mv -v gradle-${GRADLE_VERSION}  /opt/gradle/ \
    && rm -vf gradle-${GRADLE_VERSION}-bin.zip

ARG BAZEL_VERSION
ENV BAZEL_VERSION ${BAZEL_VERSION:-0.28.1}
RUN cd /tmp \
    && curl -L -O -k https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh \
    && chmod +x bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh  \
    && ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh \
    && rm -f ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh


ENV M2_HOME /opt/apache-maven/
ENV M2 $M2_HOME/bin
ENV MAVEN_OPTS "-Dstyle.info=bold,green -Dstyle.project=bold,magenta -Dstyle.warning=bold,yellow \
        -Dstyle.mojo=bold,cyan -Xmx1048m -Xms256m -XX:MaxPermSize=312M"

ENV PATH $PATH:/opt/apache-maven/bin/:/opt/jdk1.8.0_202/bin:/opt/jdk1.8.0_202/jre/bin:/opt/cmake/bin
ENV PATH $PATH:/opt/gradle/gradle-${GRADLE_VERSION}/bin

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
    && curl -L -O -k https://dl.bintray.com/boostorg/release/1.69.0/source/boost_1_69_0.tar.gz \
    && tar xfz boost_1_69_0.tar.gz > /dev/null \
    && cd boost_1_69_0 \
    && ./bootstrap.sh --prefix=/usr/ \
    && ./b2 --help \
    && ./b2 link=shared threading=multi variant=release address-model=64 \
    && ./b2 install \
    && cd /tmp \
    && rm -rvf boost_1_69_0 boost_1_69_0.tar.gz

#sml requires GCC >= 6.0.0
#RUN if [ "$(gcc --version | head -n1 | cut -d" " -f4)" -lt 6.0.0 ]; then  \
#	echo "SML Not installed GCC Less than 5.0.0"; else \
#	echo "Greater than 5.0.0"; fi
#    && git clone --depth=1 https://github.com/boost-experimental/sml.git \
#    && cd sml \
#    && cmake -E make_directory build \
#    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
#    && cmake --build build --target all --clean-first  \
#    && cmake --build build --target install \
#    && cd /tmp \
#    && rm -rvf sml

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

RUN cd /tmp && curl -L -O -k http://www-us.apache.org/dist//xerces/c/3/sources/xerces-c-3.2.2.tar.gz \
   && tar -xvzf xerces-c-3.2.2.tar.gz  > /dev/null \
   && cd xerces-c-3.2.2/ \
   && ./configure --prefix=/usr/ \
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
    && ./configure --prefix=/usr/ --enable-threads --enable-posix-shm \
        --enable-allocator-guard-pages --enable-pool-concurrency-check --enable-other-child \
    && make clean && make && make install  \
    && cd /home \
    && rm -rvf apr-1.6.5.tar.gz apr-1.6.5

RUN cd /home \
    && git clone --depth=1 https://github.com/libexpat/libexpat.git  \
    && cd libexpat/expat  \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/ \
    && cmake --build build --target all --clean-first  \
    && cmake --build build --target install \
    && cd /home \
    && rm -rvf libexpat

RUN cd /home \
    && curl -L -O -k https://www-us.apache.org/dist//apr/apr-util-1.6.1.tar.gz  \
    && tar -xvzf apr-util-1.6.1.tar.gz > /dev/null  \
    && cd apr-util-1.6.1 \
    && ./configure --prefix=/usr/ --with-apr=/usr/ --with-expat=/usr/ \
    && make clean && make && make install  \
    && cd /home \
    && rm -rvf apr-util-1.6.1.tar.gz apr-util-1.6.1

RUN cd /home \
    && GIT_SSL_NO_VERIFY=1 git clone --depth=1 https://gitbox.apache.org/repos/asf/logging-log4cxx.git  \
    && cd logging-log4cxx  \
    && ./autogen.sh \
    && ./configure --prefix=/usr/ --with-apr=/usr/ --with-apr-util=/usr/ \
        --enable-char --enable-wchar_t --with-charset=utf-8 --with-logchar=utf-8 \
    && make clean && make && make install  \
    && cd /home \
    && rm -rvf logging-log4cxx

ARG RTI_DDS_VERSION=6.0.0

COPY src/main/resources/docker/amd64/rti/packages/rti_connext_dds-${RTI_DDS_VERSION}-pro-host-x64Linux.run /tmp/

RUN cd /tmp/ \
      && chmod +x /tmp/rti_connext_dds-${RTI_DDS_VERSION}-pro-host-x64Linux.run  \
      && ./rti_connext_dds-${RTI_DDS_VERSION}-pro-host-x64Linux.run  --mode unattended --prefix /opt --disable_copy_examples true \
      && rm -rvf /tmp/rti_connext_dds-${RTI_DDS_VERSION}-pro-host-x64Linux.run

COPY src/main/resources/docker/amd64/rti/packages/rti_license.dat /opt/rti_connext_dds-${RTI_DDS_VERSION}/
COPY src/main/resources/docker/amd64/rti/packages/*.rtipkg  /tmp/
COPY src/main/resources/docker/amd64/rti/packages/*.tar.gz  /tmp/

ARG AMD_PREFIX=x64Linux3gcc5.4.0
ENV NDDSHOME=/opt/rti_connext_dds-${RTI_DDS_VERSION}
ENV PATH="${PATH}:${NDDSHOME}/bin"
ENV LD_LIBRARY_PATH=/opt/rti_connext_dds-${RTI_DDS_VERSION}/lib/${AMD_PREFIX}

RUN cd /tmp/ \
# kept OpenSSL_1_0_2 for compatibility with the one provided by RTI (openssl-1.0.2n-5.3.1-host-x64Linux.rtipkg)
    && GIT_SSL_NO_VERIFY=1 git clone --depth=1 -b OpenSSL_1_0_2-stable https://github.com/openssl/openssl.git  openssl \
    && cd openssl \
#    && ./config --prefix=/usr shared enable-ec enable-ecdh enable-ecdsa \
    && ./config --prefix=/usr  \
    && make \
    && make install \
    && cd /tmp/ \
    && rm -rvf openssl


RUN cd /tmp/ \
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
    && rm -rvf /tmp/*.rtipkg
    
RUN cd /tmp/ \
    # && mkdir -pv /opt/rti_connext_openssl/{target-x64Linux3gcc5.4.0,target-x64Linux4gcc7.3.0,target-armv8Linux4.4gcc5.4.0} \
    && mkdir -pv /opt/rti_connext_openssl/target-x64Linux3gcc5.4.0 \
    && mkdir -pv /opt/rti_connext_openssl/target-x64Linux4gcc7.3.0 \
    && mkdir -pv /opt/rti_connext_openssl/target-armv8Linux4.4gcc5.4.0 \
    && tar -zvxf openssl-1.0.2o-target-armv8Linux4.4gcc5.4.0.tar.gz -C /opt/rti_connext_openssl/target-armv8Linux4.4gcc5.4.0 --strip-components=1 \
    # && tar -zvxf openssl-1.0.2o-target-x64Linux4gcc7.3.0.tar.gz -C /opt/rti_connext_openssl/target-x64Linux4gcc7.3.0 --strip-components=1 \
    && tar -zvxf openssl-1.0.2o-target-x64Linux3gcc5.4.0.tar.gz -C /opt/rti_connext_openssl/target-x64Linux3gcc5.4.0 --strip-components=1 \
    && rm -rvf /tmp/*.tar.gz

# RUN cd /tmp \
  # && curl -o vscode-amd64.deb -L -O -k   https://go.microsoft.com/fwlink/?LinkID=760868 \
  # && dpkg -i vscode-amd64.deb \
  # &&  rm vscode-amd64.deb

ENV BULLSEYE_VERSION ${BULLSEYE:-8.15.31}
RUN cd /tmp/ \
    && curl -Lk http://www.bullseye.com/download/BullseyeCoverage-$BULLSEYE_VERSION-Linux-x64.tar | tar x -C /opt \ 
   ##&&  echo | /opt/BullseyeCoverage-$BULLSEYE_VERSION/install --key 4ChKeY0AX2Et3CDftN2cqkhg0NUEf03o4gQX \ 
    && echo | /opt/BullseyeCoverage-$BULLSEYE_VERSION/install --key 2Ct8nh2WOwHc2t4gvl1IYzzX1uGCW82sERqr \ 
    && rm -rf /opt/BullseyeCoverage-$BULLSEYE_VERSION*
 
 ENV PATH /opt/BullseyeCoverage/bin:$PATH
#export COVFILE=$HOME/bullseye.cov && cov01 --on && cov01 --status && make -j12 && cov01 --off

ARG  ACCOUNT=happyman
RUN useradd -ms /bin/bash $ACCOUNT
RUN chown -R $ACCOUNT:$ACCOUNT /home/$ACCOUNT
USER $ACCOUNT
WORKDIR /home/$ACCOUNT
CMD ["/bin/bash"]

