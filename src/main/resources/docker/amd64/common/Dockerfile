FROM docker.io/doevelopper/dind:0.0.2
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN apt-get -qq -o Acquire::Check-Valid-Until="false" update --assume-yes \
   && apt-get -qq install --assume-yes --no-install-recommends libtool apt-transport-https ca-certificates autotools-dev\
        git xz-utils unzip wget curl openssh-server  openssh-client  automake \
        bison flex build-essential gawk libgcrypt20-dev libcrypto++-dev vim texinfo \
        python-pip python3-pip python-dev python3-dev python-wheel cython cython3 python3-wheel \
        perl-base perl-modules zlib1g-dev \
        libxml2-dev libxml2-utils python3-setuptools python-setuptools \
        libgnutls28-dev libcurl4-gnutls-dev libgnutls-openssl27 \
        mesa-common-dev libglu1-mesa-dev libpcap-dev libxrender1 libxkbcommon-x11-0 \
        libfontconfig libldap2-dev libldap-2.4-2  libmysql++-dev \
        unixodbc-dev libgdbm-dev libodb-pgsql-dev libcrossguid-dev  uuid-dev libossp-uuid-dev \
        libghc-uuid-dev libghc-uuid-types-dev ruby ruby-dev libelf-dev  elfutils libelf1 \
        libpulse-dev  make nfs-common  xvfb  xauth xterm iputils-ping  tmux vim-nox \
        htop libxss1 libasound2 x11-apps dbus gpg \
        libc6-dev libgtk-3-0 libpango-1.0-0 \
        htop emacs25  rxvt-unicode-256color valgrind mscgen graphviz \
        x11-xserver-utils libxkbfile1  > /dev/null 2>&1 \
   && mkdir -pv /var/run/dbus \
   && apt-get clean --assume-yes  \
   && apt-get --assume-yes --quiet clean \
   && apt-get --assume-yes --quiet autoremove \
   && rm -rvf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/* \
   && rm -rf /usr/share/man/

        # libcairo2 libfontconfig1 libnss3 libxtst6 libglib2.0-bin \
        # libcanberra-gtk-module libgl1-mesa-glx gettext libstdc++6 \
        # software-properties-common autogen libnotify-bin \

ARG MAKEFLAGS

RUN cd /tmp \
   && wget http://ftp.gnu.org/gnu/gdb/gdb-8.3.tar.gz \
   && tar -xzf gdb-8.3.tar.gz \
   && cd gdb-8.3 \
   && ./configure > /dev/null 2>&1 \
   && make > /dev/null 2>&1 \
   && make install > /dev/null 2>&1 \
   && cd /tmp \
   && rm -rf gdb-8.3.tar.gz gdb-8.3

ENV CMAKE_MAJOR_VERSION ${CMAKE_MAJOR_VERSION:-3.15}
ENV CMAKE_VERSION ${CMAKE_VERSION:-${CMAKE_MAJOR_VERSION}.2}
RUN cd /tmp \
   && curl -L -O -k https://cmake.org/files/v${CMAKE_MAJOR_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
   && tar -xzf cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz > /dev/null 2>&1 \
   && rm cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
   && mv cmake-${CMAKE_VERSION}-Linux-x86_64 /opt/cmake

RUN  cd /tmp \
   && wget --no-check-certificate https://github.com/ninja-build/ninja/releases/download/v1.9.0/ninja-linux.zip\
   && unzip ninja-linux.zip > /dev/null 2>&1 \
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
#RUN conan remote add artifactory https://devcloud.swcoe.ge.com/artifactory/api/conan/GRIDIQ-CONAN
#RUN conan user -p ${ARTIFACTORY_PSW} -r artifactory ${ARTIFACTORY_USR}
#RUN conan create --update -e ARTIFACTORY_USR=${ARTIFACTORY_USR} -e ARTIFACTORY_PSW=${ARTIFACTORY_PSW} -e AIMMS_HOME=/opt/aimms/ -s build_type=${BUILD_TYPE} . gridiq/dev
## Run deploy if configured to do so.  
#RUN if [ "${BUILD_GOAL}" = "deploy" ]; then conan upload --all --force -c -r=artifactory KoshCpp/*; fi
#RUN conan install . -s os=Linux -s os_build=Linux -s arch=x86_64 -s arch_build=x86_64 -s compiler=gcc -s compiler.version=7 -s compiler.libcxx=libstdc++11 && \
#    mkdir build && cd build && \
#    cmake .. -G "Unix Makefiles"
    
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
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local > /dev/null 2>&1 \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install \
   && cd /tmp \
   && rm -rf uncrustify

RUN cd /tmp \
   && git clone --depth=1 https://github.com/danmar/cppcheck.git \
   && cd cppcheck \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local > /dev/null 2>&1 \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install \
   && cp --recursive --verbose cfg  /usr/local/bin || true \
   && cd /tmp \
   && rm -rf cppcheck

RUN cd /tmp \
   && git clone --depth=1 https://github.com/doxygen/doxygen.git  \
   && cd doxygen \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local > /dev/null 2>&1 \
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
   && cmake -E chdir build cmake .. -DBENCHMARK_ENABLE_TESTING=OFF -DCMAKE_INSTALL_PREFIX=/usr/local > /dev/null 2>&1 \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install \
   && cd /tmp \
   && rm -rf benchmark

# RUN pip install cmakedoc
# RUN cd /tmp \
   # && git clone --depth=1 https://github.com/jeaye/stdman.git \
   # && cd stdman \
   # && ./configure --prefix=/usr \
   # && make install \
   # && cd /tmp \
   # && rm -Rf stdman

ENV MANPATH=${MANPATH}:/usr/local/man:/usr/local/share/man:/usr/share/man:/usr/man

ARG BOOST_VERSION_MAJ=1
ARG BOOST_VERSION_MIN=69
ARG BOOST_VERSION_PATCH=0
ARG BOOST_VERSION=1.69.0
ARG BOOST_RELEASE=${BOOST_VERSION_MAJ}_${BOOST_VERSION_MIN}_${BOOST_VERSION_PATCH}
RUN cd /tmp \
   && curl -L -O -k https://dl.bintray.com/boostorg/release/${BOOST_VERSION}/source/boost_${BOOST_RELEASE}.tar.gz \
   && tar xzf boost_${BOOST_RELEASE}.tar.gz \
   && cd boost_${BOOST_RELEASE} \
   && ./bootstrap.sh --prefix=/usr/ --with-python=python3 \
   && ./b2 --help \
   && ./b2 link=shared threading=multi variant=release address-model=64 > /dev/null 2>&1 \
   && ./b2 install --prefix=/usr/ > /dev/null 2>&1\
   && cd /tmp \
   && rm -rf boost_${BOOST_RELEASE} boost_${BOOST_RELEASE}.tar.gz

#sml requires GCC >= 6.0.0
RUN cd /tmp \
   && git clone --depth=1 https://github.com/boost-experimental/sml.git \
   && cd sml \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local > /dev/null 2>&1 \
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
   && cmake -E chdir build cmake -DCUKE_ENABLE_EXAMPLES=off -DCMAKE_CXX_FLAGS=-std=c++11 -DCMAKE_INSTALL_PREFIX=/usr/local .. > /dev/null 2>&1 \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install \
   && cd /tmp \
   && rm -rf cucumber-cpp

RUN cd /tmp \
   && git clone --depth=1 https://github.com/google/double-conversion.git \
   && cd double-conversion \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local > /dev/null 2>&1 \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install \
   && cd /tmp \
   && rm -rf double-conversion

#RUN cd /tmp \
#   && git clone --depth=1 https://github.com/google/cctz.git \
#   && cd cctz \
#   && cmake -E make_directory build \
#   && cmake -E chdir build cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_INSTALL_PREFIX=/usr/local \
#   && cmake --build build --target all --config Release --clean-first > /dev/null 2>&1 \
#   && ctest \
#   && cmake --build build --config Release --target install \
#   && cd /tmp \
#   && rm -rf cctz

RUN cd /tmp \
   && git clone --depth=1 https://github.com/google/capture-thread.git \
   && cd capture-thread \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local > /dev/null 2>&1 \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install \
   && cd /tmp \
   && rm -rf capture-thread

# RUN cd /tmp \
   # && git clone --depth=1 https://github.com/google/statechart.git \
   # && cd statechart \
   # && bazel build //statechart/... \
   # && bazel test //statechart/... \
   # && bazel run //statechart/example:microwave_example_main -- --alsologtostderr \
   # && cd /tmp
#   && rm -rvf statechart

RUN cd /tmp \
#    && GIT_SSL_NO_VERIFY=1 git clone --depth=1 -b OpenSSL_1_0_2-stable https://github.com/openssl/openssl.git  openssl \
   && GIT_SSL_NO_VERIFY=1 git clone --depth=1 --recurse-submodules https://github.com/openssl/openssl.git  openssl \
   && cd openssl \
#    && ./config --prefix=/usr shared enable-ec enable-ecdh enable-ecdsa \
#    && ./config --prefix=/usr  \
   && ./config --prefix=/usr shared > /dev/null 2>&1 \
   && make > /dev/null 2>&1 \
   && make install \
   && cd /tmp \
   && rm -rf openssl

RUN cd /tmp \
   && git clone --depth=1 https://github.com/protocolbuffers/protobuf.git \
   && cd protobuf \
   && ./autogen.sh \
#    && ./configure --enable-samples --with-openssl=/usr --with-zlib=/usr --prefix=/usr/ \
   && ./configure --prefix=/usr/ > /dev/null 2>&1 \
   && make clean \ 
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
           --enable-msgloader-inmemory --enable-xmlch-uint16_t --enable-xmlch-char16_t > /dev/null 2>&1 \
   && make clean\
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
   && ./configure --prefix=/usr/ --enable-threads --enable-posix-shm \
        --enable-allocator-guard-pages --enable-pool-concurrency-check --enable-other-child > /dev/null 2>&1 \
   && make clean  \
   && make > /dev/null 2>&1 \
   && make install  \
   && cd /tmp \
   && rm -rf apr-${APR_VERSION}.tar.gz apr-${APR_VERSION}

RUN cd /tmp \
   && git clone --depth=1 https://github.com/libexpat/libexpat.git  \
   && cd libexpat/expat  \
   && cmake -E make_directory build \
   && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/  > /dev/null 2>&1 \
   && cmake --build build --target all --clean-first > /dev/null 2>&1 \
   && cmake --build build --target install \
   && cd /tmp \
   && rm -rf libexpat

ARG APU_VERSION=1.6.1
RUN cd /tmp \
   && curl -L -O -k https://www-us.apache.org/dist//apr/apr-util-${APU_VERSION}.tar.gz  \
   && tar -xzf apr-util-${APU_VERSION}.tar.gz  \
   && cd apr-util-${APU_VERSION} \
   && ./configure --prefix=/usr/ --with-apr=/usr/ --with-expat=/usr/ > /dev/null 2>&1 \
   && make clean \
   && make > /dev/null 2>&1 \
   && make install  \
   && cd /tmp \
   && rm -rf apr-util-${APU_VERSION}.tar.gz apr-util-${APU_VERSION}

RUN cd /tmp \
   && GIT_SSL_NO_VERIFY=1 git clone --depth=1 https://gitbox.apache.org/repos/asf/logging-log4cxx.git  \
   && cd logging-log4cxx  \
   && ./autogen.sh \
   && ./configure --prefix=/usr/ --with-apr=/usr/ --with-apr-util=/usr/ \
        --enable-char --enable-wchar_t --with-charset=utf-8 --with-logchar=utf-8 > /dev/null 2>&1 \
   && make clean \ 
   && make > /dev/null 2>&1 \ 
   && make install  \
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
	&& ./configure --prefix=/usr/local > /dev/null 2>&1 \
	&& make > /dev/null 2>&1 \
	&& make install \
	&& cd /tmp \
	&& rm -Rf breakpad

RUN cd /opt \
   && git clone https://chromium.googlesource.com/chromium/tools/depot_tools
ENV  PATH /opt/depot_tools:$PATH


# RUN cd /tmp \
	# && git clone --depth=1 https://github.com/Snaipe/Criterion.git \
    # && cd Criterion \
    # && cmake -E make_directory build \
    # && cmake -E chdir build cmake .. -DUSE_CPP14=1 -DCMAKE_INSTALL_PREFIX=/usr/local \
    # && cmake --build build --target all --clean-first \
    # && cmake --build build --target install || true \
    # && cd /tmp \
    # && rm -Rf Criterion

# RUN cd /tmp \
  # && wget -O vscode-amd64.deb  https://go.microsoft.com/fwlink/?LinkID=760868 \
  # && dpkg -i vscode-amd64.deb \
  # &&  rm vscode-amd64.deb

#ADD ./src/main/resources/docker/amd64/vscode-ext.sh /tmp/

#RUN cd /tmp \
#    && chmod +x vscode-ext.sh\ 
#    && ./vscode-ext.sh \ 
#    && rm -vf vscode-ext.sh

ARG ACCOUNT=developer
# Add a new group '${ACCOUNT}s' with ID 1000
# Add a new user  '$ACCOUNT' with ID 1000
# Add $ACCOUNT to sudoers list with no password required
# Make 'bash' the default shell for everyone
RUN set -ex 	cut -d: -f1 /etc/group
RUN set -ex 	cut -d: -f1 /etc/passwd
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
CMD ["/bin/bash"]
