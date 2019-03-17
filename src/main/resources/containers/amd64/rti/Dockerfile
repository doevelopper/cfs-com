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

RUN curl -L -O -k https://cmake.org/files/v3.14/cmake-3.14.0-rc4-Linux-x86_64.tar.gz \
    && tar -xvf cmake-3.14.0-rc4-Linux-x86_64.tar.gz > /dev/null \
    && rm -v cmake-3.14.0-rc4-Linux-x86_64.tar.gz \
    && mv -v cmake-3.14.0-rc4-Linux-x86_64 /opt/cmake

RUN  cd /tmp \
    && wget --no-cookies --no-check-certificate \
       --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie"\
       "https://download.oracle.com/otn-pub/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-linux-x64.tar.gz" \
    && tar -xvzf jdk-8u202-linux-x64.tar.gz -C /opt/ \
    && rm -v jdk-8u202-linux-x64.tar.gz

RUN cd /tmp \
    &&  wget --no-check-certificate https://www-eu.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz \
    && tar -xvzf apache-maven-3.6.0-bin.tar.gz \
    && mv apache-maven-3.6.0/ /opt/apache-maven \
    && rm -v apache-maven-3.6.0-bin.tar.gz

RUN cd /tmp \
    && curl -L -O -k https://downloads.gradle.org/distributions/gradle-5.2.1-bin.zip \
    && mkdir -pv /opt/gradle \
#    && unzip -d /opt/gradle gradle-5.2.1-bin.zip \
    && unzip gradle-5.2.1-bin.zip \
    && mv -v gradle-5.2.1  /opt/gradle/ \
    && rm -vf gradle-5.2.1-bin.zip

ENV JAVA_HOME /opt/jdk1.8.0_202
ENV JRE_HOME /opt/jdk1.8.0_202/jre
ENV M2_HOME /opt/apache-maven/
ENV M2 $M2_HOME/bin
ENV MAVEN_OPTS "-Dstyle.info=bold,green -Dstyle.project=bold,magenta -Dstyle.warning=bold,yellow \
        -Dstyle.mojo=bold,cyan -Xmx1048m -Xms256m -XX:MaxPermSize=312M"

ENV PATH $PATH:/opt/apache-maven/bin/:/opt/jdk1.8.0_202/bin:/opt/jdk1.8.0_202/jre/bin:/opt/cmake/bin
ENV PATH $PATH:/opt/gradle/gradle-5.2.1/bin

RUN cmake --version \
    && make --version \
    && gcc --version \
    && java -version \
    && mvn --version \
    && gradle -v

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
    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
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

ARG  ACCOUNT=happyman
RUN useradd -ms /bin/bash $ACCOUNT
RUN chown -R $ACCOUNT:$ACCOUNT /home/$ACCOUNT
USER $ACCOUNT

WORKDIR /home/$ACCOUNT
CMD ["/bin/bash"]

