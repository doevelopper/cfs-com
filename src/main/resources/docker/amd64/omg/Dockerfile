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

ARG OPENDDS_BUILD_OPTIONS="-std=c++11 --ipv6 --openssl --xerces3=/usr/local --java --rapidjson --glib --boost=/usr"
ARG OPENDDS_BUILD_CONFIG_OPTIONS="--no-tests --no-inline --macros=c++11=1 --no-debug --optimize"
ARG DDS_BUILD_CONFIG_OPTIONS="--security --safety-profile=base --cmake=/opt/cmake/bin/"
ARG DDS_SAFETY_BASE_NO_BUILTIN_TOPICS="--safety-profile=base --no-built-in-topics"
ARG DDS_SECURITY="--security --features=versioned_namespace=1"
# ARG DDS_WITHOUTFEATURES "--no-inline --no-debug --no-built-in-topics --no-content-subscription --no-ownership-profile --no-object-model-profile --no-persistence-profile --security"
ARG DDS_BUILD_MACRO="--macros=c++11=1"
ARG DDS_BUILD_MACRO_1="--macros=CPPFLAGS+=-Wno-deprecated -Wno-unused-result"
ARG DDS_BUILD_MACRO_2="--macros=CPPFLAGS+=-Wno-deprecated-declarations -Wno-implicit-fallthroug -Wno-unused-result"
ARG DDS_BUILD_SECURITY_OPTIONS="--security --safety-profile=base"
ARG DDS_BUILD_QT_OPTIONS="--qt --wireshark=/usr/include/wireshark/"

ARG GET_DDS_VERSION="DDS-3.13-2"
ARG DDS_SRCS_LINUX="https://github.com/objectcomputing/OpenDDS/releases/download/DDS-3.13.2/OpenDDS-3.13.2.tar.gz"
ARG DDS_REPO="https://github.com/objectcomputing/OpenDDS.git"

RUN git config --global url."https://github.com/".insteadOf "git@github.com:"
RUN git config --global url."https://".insteadOf git://

USER root

# Core libraries
RUN apt-get -qq install -y \
    libglu1-mesa-dev libxrender1 libxkbcommon-x11-0

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install --assume-yes --no-install-recommends nodejs

ENV Q_MAJOR_VERSION ${Q_MAJOR_VERSION:-5.13}
ENV Q_VERSION ${Q_VERSION:-${Q_MAJOR_VERSION}.0}

COPY qt-installer-noninteractive.qs /tmp

RUN cd /tmp\
    && curl -L -O "http://download.qt.io/official_releases/qt/${Q_MAJOR_VERSION}/${Q_VERSION}/qt-opensource-linux-x64-${Q_VERSION}.run" \
    && chmod +x qt-opensource-linux-x64-${Q_VERSION}.run \
    && ./qt-opensource-linux-x64-${Q_VERSION}.run --script qt-installer-noninteractive.qs \
    && rm -vf qt-opensource-linux-x64-${Q_VERSION}.run

ENV QTDIR=/opt/Qt${Q_VERSION}/${Q_VERSION}/gcc_64
ENV CMAKE_PREFIX_PATH=/opt/Qt${Q_VERSION}/${Q_VERSION}/gcc_64:$CMAKE_PREFIX_PATH
ENV PATH="${QTDIR}/bin/:/opt/Qt${Q_VERSION}/Tools/QtCreator/bin:${PATH}"
    # && export CMAKE_PREFIX_PATH=/opt/Qt${QT_VERSION_STR}/${QT_VERSION_STR}/gcc_64:$CMAKE_PREFIX_PATH \
    # && export QTDIR=/opt/Qt${QT_VERSION_STR}/${QT_VERSION_STR}/gcc_64 \
RUN cd /tmp \
    && GIT_SSL_NO_VERIFY=1 git clone --depth=1 --recurse-submodules https://github.com/wireshark/wireshark.git \
    && cd wireshark \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=${DEPS_INSTALL_DIR} \
    && cmake --build build --target all --clean-first \
    && cmake --build build --target install \
    cd /tmp \
    rm -Rf wireshark

ENV DDS_BASE_DIR=/opt/dds


RUN cd /tmp \
    && git clone --depth=1 https://github.com/DOCGroup/CIAO.git \
    && git clone --depth=1 https://github.com/DOCGroup/DAnCE.git \
    && git clone --depth=1 https://github.com/DOCGroup/MPC.git \
    && git clone --depth=1 git://github.com/DOCGroup/ACE_TAO.git \
    && git clone --depth=1 --recurse-submodules https://github.com/objectcomputing/OpenDDS.git \
    && export ACE_TAO_ROOT=/tmp/ACE_TAO \
    && export ACE_ROOT=$ACE_TAO_ROOT/ACE \
    && export TAO_ROOT=$ACE_TAO_ROOT/TAO \
    && export CIAO_ROOT=/tmp/CIAO \
    && export DANCE_ROOT=/tmp/DAnCE \
    && export MPC_ROOT=/tmp/MPC \
    && export LD_LIBRARY_PATH=:${LD_LIBRARY_PATH}:${pwd}/build/target/ACE_TAO/ACE/lib:${ACE_ROOT}/lib:${pwd}/build/target/lib:${pwd}/lib \
	&& echo -e "#include \"ace/config-linux.h\"" >> $ACE_ROOT/ace/config.h \
	&& echo -e "#define ACE_FACE_SAFETY_BASE" >> $ACE_ROOT/ace/config.h \
	&& echo -e "uses_wchar=1" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
	&& echo -e "versioned_namespace=1" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
	&& echo -e "xerces3=1\nssl=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
	&& echo -e "inline=0\nipv6=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
	&& echo -e "xerces3=1\nssl=1\n" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
	&& echo -e "c++11=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
	&& echo -e "include \$(ACE_ROOT)/include/makeinclude/platform_linux.GNU" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    && cd OpenDDS \
    && ./configure --help \
    && ./configure --prefix=${DDS_BASE_DIR} \
            ${OPENDDS_BUILD_OPTIONS} \
            ${OPENDDS_BUILD_CONFIG_OPTIONS} \
            ${DDS_SECURITY} \
            --cmake=/opt/cmake/bin/ \
            --ace=$ACE_ROOT \
            --tao=$TAO_ROOT \
            --mpc=$MPC_ROOT \
            --mpcopts="-workers 4" --features=uses_wchar=1 \
    && ./tools/scripts/show_build_config.pl || true \
    && make > /dev/null 2>&1 \
    && make install > /dev/null 2>&1

ENV ACE_TAO_ROOT=$DDS_BASE_DIR/ACE_TAO
ENV ACE_ROOT=$ACE_TAO_ROOT/ACE
ENV TAO_ROOT=$ACE_TAO_ROOT/TAO
ENV CIAO_ROOT=$DDS_BASE_DIR/CIAO
ENV DANCE_ROOT=$DDS_BASE_DIR/DAnCE
ENV MPC_ROOT=$DDS_BASE_DIR/MPC
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$ACE_ROOT/lib:$LD_LIBRARY_PATH

ENV PATH="${PATH}:${ACE_ROOT}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

RUN cd /tmp \
    && git clone --depth=1 https://github.com/DOCGroup/XSC.git \
    && export ACE_ROOT=/tmp/build_dir/ACE_TAO/ACE/ \
    && export MPC_ROOT=/tmp/build_dir/MPC \
    && cd XSC \
    && perl $ACE_ROOT/bin/mwc.pl -type gnuace -workers 2 XSC.mwc \
    && mkdir -pv ${DDS_BASE_DIR}/XSC \
    && make > /dev/null 2>&1 \
    && DESTDIR=${DDS_BASE_DIR}/XSC make install > /dev/null 2>&1

RUN cd /tmp \
    && git clone --depth=1 --recurse-submodules  https://github.com/omg-dds/dds-rtps.git \
    && git clone --depth=1 --recurse-submodules  https://github.com/omg-dds/dds-xtypes.git \
    && git clone --depth=1 --recurse-submodules https://github.com/omg-dds/dds-security.git \
    && cd dds-security

# ENV ACE_ROOT=/usr/local/share/ace \
    # TAO_ROOT=/usr/local/share/tao \
    # DDS_ROOT=/usr/local/share/dds \
    # LD_LIBRARY_PATH=$ACE_ROOT/lib:$LD_LIBRARY_PATH \


#https://github.com/RemedyIT/dancex11.git
#https://github.com/RemedyIT/ciaox11.git
#    && export CMAKE_INSTALL_PREFIX=/usr/
#    && export QTDIR: /opt/Qt5.11.2/5.11.2/gcc_64

# RUN cd /tmp \
    # && git clone --depth=1 --recursive https://github.com/objectcomputing/mFAST.git \
    # && cd mFAST \
    # && cmake -E make_directory build \
    # && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local > /dev/null 2>&1 \
    # && cmake --build build --target all --clean-first > /dev/null 2>&1 \
    # && cmake --build build --target install > /dev/null 2>&1 \
    # && cd /tmp

#ENV ACE_ROOT=/usr/local/share/ace \
#    TAO_ROOT=/usr/local/share/tao \
#    DDS_ROOT=/usr/local/share/dds \
#    LD_LIBRARY_PATH=$ACE_ROOT/lib:$LD_LIBRARY_PATH \
#    PATH=".:${PATH}:/usr/local/share/ace/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

#RUN cd /root \
#    && git clone https://github.com/objectcomputing/liquibook.git \
#    && cd liquibook/ \
#    && git submodule init \
#    && git submodule update \
#    &&  . ./env.sh \
#    && mwc.pl -type make liquibook.mwc \
#    && make depend \
#    && make all

#RUN cd /tmp \
#    && git clone --depth=1 git://github.com/DOCGroup/MPC.git \
#    && git clone --depth=1 git://github.com/DOCGroup/DAnCE.git \
#    && git clone --depth=1 git://github.com/DOCGroup/ACE_TAO.git ATCD \
#    && git clone --depth=1 https://github.com/DOCGroup/CIAO.git \
#    && export ACE_TAO_ROOT=/tmp/ATCD/ \
#    && export ACE_ROOT=${ACE_TAO_ROOT}/ACE/ \
#    && export TAO_ROOT=${ACE_TAO_ROOT}/TAO/ \
#    && export CIAO_ROOT=/tmp/CIAO \
#    && export DANCE_ROOT=/tmp/DAnCE \
#    && export MPC_ROOT=/tmp/MPC \
#    && LD_LIBRARY_PATH=$ACE_ROOT/lib:$LD_LIBRARY_PATH \
#    && perl $ACE_ROOT/bin/mwc.pl -type gnuace -workers 6 travis.mwc \
#    && make -j `nproc`

# RUN cd /opt \
	# && git clone --depth=1 https://github.com/DOCGroup/ACE_TAO.git \
	# && cd ACE_TAO \
	# && export ACE_ROOT=/opt/ACE_wrappers \
	# && export TAO_ROOT=$ACE_ROOT/TAO \
	# && export PATH=$PATH:$ACE_ROOT/bin \
	# && export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ACE_ROOT/lib \
	# && echo -e "#include \"ace/config-linux.h\"" >> $ACE_ROOT/ace/config.h; \
	# && echo -e "#define ACE_FACE_SAFETY_BASE" >> $ACE_ROOT/ace/config.h
	# && echo -e "corba_e_micro=1" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU
	# && echo -e "corba_e_micro=1" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features
	# && echo -e "corba_e_compact=1" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU;
	# && echo -e "corba_e_compact=1" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features;
	# && echo -e "ace_for_tao=1" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU;
	# && echo -e "ace_for_tao=1" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features
	# && echo -e "ccm_lw=1" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features
	# && echo -e "ccm_noevent=1" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features;
	# && echo -e "uses_wchar=1" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features;
	# && echo -e "versioned_namespace=1" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features;
	# && echo -e "xerces3=1\nssl=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU;
	# && echo -e "inline=0\nipv6=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU
	# && echo -e "xerces3=1\nssl=1\n" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features;
	# && echo -e "c++11=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU;
	# && echo -e "include \$(ACE_ROOT)/include/makeinclude/platform_linux.GNU" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU;
	# && cd $ACE_ROOT/ace \
	# && make \
	# && cd $ACE_ROOT/apps/gperf/src \
	# && make \
	# && cd $TAO_ROOT \
	# && make \
	# && cd ..

ARG ACCOUNT
ENV ACCOUNT ${ACCOUNT:-developer}
RUN chown -R $ACCOUNT:$ACCOUNT /home/$ACCOUNT
USER $ACCOUNT

WORKDIR /home/$ACCOUNT
CMD ["/bin/bash"]
