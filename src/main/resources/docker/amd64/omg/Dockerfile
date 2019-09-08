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

ARG DDS_DEV_IMAGE=docker.io/doevelopper/cfs-com-common:latest
FROM $DDS_DEV_IMAGE

USER root

RUN git config --global url."https://github.com/".insteadOf "git@github.com:"
RUN git config --global url."https://".insteadOf git://
#RUN git config --global url."https".insteadOf "git+https"

ENV PKG_CONFIG_PATH=${QTDIR}/lib/pkgconfig:$PKG_CONFIG_PATH

ARG ACE_MAJOR_VERSION=6
ARG ACE_MINOR_VERSION=5
ARG ACE_PATCH_VERSION=6
ARG ACE_TAO_VERSION=${ACE_MAJOR_VERSION}.${ACE_MINOR_VERSION}.${ACE_PATCH_VERSION}
ARG ACE_TAO_RELEASE=${ACE_MAJOR_VERSION}_${ACE_MINOR_VERSION}_${ACE_PATCH_VERSION}

ARG OPENDDS_SECURITY_OPTIONS="--security"
ARG OPENDDS_BUILD_OPTIONS="--std=c++11 --ipv6 --openssl=/usr/local --xerces3=/usr/local --java --rapidjson --glib --boost=/usr/local"
ARG OPENDDS_BUILD_CONFIG_OPTIONS="--no-tests --no-inline --features=versioned_namespace=1 --macros=c++11=1 --no-debug --optimize"
ARG OPENDDS_QT_OPTIONS="--qt"
ARG DDS_BUILD_CONFIG_OPTIONS="--security --safety-profile=base --cmake=/opt/cmake/bin/"
ARG DDS_SAFETY_BASE_NO_BUILTIN_TOPICS="--safety-profile=base --no-built-in-topics"
ARG DDS_WITHOUTFEATURE="--no-inline --no-debug --no-built-in-topics --no-content-subscription --no-ownership-profile --no-object-model-profile --no-persistence-profile --security"
ARG DDS_BUILD_MACRO="--macros=CPPFLAGS+=-Wno-deprecated -Wno-unused-result"
ARG DDS_BUILD_MACRO_1="--macros=CPPFLAGS+=-Wno-deprecated-declarations -Wno-implicit-fallthroug -Wno-unused-result"
ARG EXTENDED_DDS_BUILD_SECURITY_OPTIONS="--security --safety-profile=base"
ARG DDS_BUILD_DISSECT_OPTIONS="--qt --wireshark=/usr/local/"

ARG DDS_BASE_DIR=/opt/dds
ARG DDS_INSTALL_DIR=/opt/dds_install

ARG PREFIX_PATH="${CMAKE_PREFIX_PATH:+${CMAKE_PREFIX_PATH};}${QT_DIR}"

# RUN cd /tmp/ \
    # && git clone --depth=1 --recurse-submodules https://github.com/DOCGroup/MPC.git \
    # && git clone --depth=1 --recurse-submodules https://github.com/DOCGroup/ACE_TAO.git
    # && cd ACE_TAO \
    # && export ACE_TAO_ROOT=/tmp/ACE_TAO \
    # && export ACE_ROOT=$ACE_TAO_ROOT/ACE \
    # && export TAO_ROOT=$ACE_TAO_ROOT/TAO \
    # && export MPC_ROOT=/tmp/MPC \
    # && export PATH=$PATH:$ACE_ROOT/bin \
    # && export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ACE_ROOT/lib \
    # && echo "#include \"ace/config-linux.h\"" >> $ACE_ROOT/ace/config.h \
    # && echo "workspace {\n" >> $ACE_TAO_ROOT/ACE_TAO.mwc \
    # && echo "\$(TAO_ROOT)/TAO_ACE.mwc\n\$(TAO_ROOT)/tests/Hello\n" >> $ACE_TAO_ROOT/ACE_TAO.mwc \
    # && echo "\$(ACE_ROOT)/ace/ace.mwc\n" >> $ACE_TAO_ROOT/ACE_TAO.mwc \
    # && echo "}\n" >> $ACE_TAO_ROOT/ACE_TAO.mwc \
    # && rm -vf $ACE_ROOT/include/makeinclude/platform*.GNU \
    # && echo "include \$(ACE_ROOT)/include/makeinclude/platform_linux.GNU" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    # && echo "#define ACE_FACE_SAFETY_BASE" >> $ACE_ROOT/ace/config.h \
    # && echo "corba_e_micro=1" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    # && echo "corba_e_micro=1" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    # && echo "corba_e_compact=1" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    # && echo "corba_e_compact=1" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    # && echo "ace_for_tao=1" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    # && echo "ace_for_tao=1" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    # && echo "ccm_lw=1" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    # && echo "ccm_noevent=1" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    # && echo "uses_wchar=1" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    # && echo "versioned_namespace=1" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    # && echo "xerces3=1\nssl=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    # && echo "inline=0\nipv6=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    # && echo "xerces3=1\nssl=1\n" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    # && echo "c++11=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    # && cat $ACE_TAO_ROOT/ACE_TAO.mwc \
    # && cat $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    # && cat $ACE_ROOT/ace/config.h \
    # && cat $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    # && perl $ACE_ROOT/bin/mwc.pl -type gnuace -workers 2 ACE_TAO.mwc \
    # && perl $ACE_ROOT/bin/mwc.pl  -type gnuace $TAO_ROOT/TAO_ACE.mwc \
    # && cd $ACE_ROOT \
    # && perl $ACE_ROOT/bin/mwc.pl -type gnuace -features ssl=1,qt5=1,qos=1,ace_for_tao=1 ACE.mwc \
    # && make realclean \
    # && make -j$(nproc) \
    # && mkdir -pv ${DDS_INSTALL_DIR}/ACE_TAO \
    # && INSTALL_PREFIX=${DDS_INSTALL_DIR}/ACE_TAO make install
    # && cd $ACE_ROOT/ace \
    # && make \
    # && cd $ACE_ROOT/apps/gperf/src \
    # && make \
    # && cd $TAO_ROOT \
    # && make \
    # && cd ..

ARG GET_DDS_VERSION="DDS-3.13-2"
ARG DDS_SRCS_LINUX="https://github.com/objectcomputing/OpenDDS/releases/download/DDS-3.13.2/OpenDDS-3.13.2.tar.gz"
ARG DDS_REPO="https://github.com/objectcomputing/OpenDDS.git"

# RUN cd ${DDS_BASE_DIR} \
    # && cd DAnCE \
    # && export ACE_TAO_ROOT=${DDS_BASE_DIR}/ACE_TAO \
    # && export ACE_ROOT=$ACE_TAO_ROOT/ACE \
    # && export TAO_ROOT=$ACE_TAO_ROOT/TAO \
    # && export CIAO_ROOT=${DDS_BASE_DIR}/CIAO \
    # && export DANCE_ROOT=${DDS_BASE_DIR}/DAnCE \
    # && export MPC_ROOT=${DDS_BASE_DIR}/MPC \
    # && export XSC_ROOT=${DDS_BASE_DIR}/XSC \
    # && export LD_LIBRARY_PATH=$ACE_ROOT/lib:${XSC_ROOT}/XSC/utils:${XSC_ROOT}/lib:/usr/local/lib/:$LD_LIBRARY_PATH \
    # && echo "#include \"ace/config-linux.h\"" >> $ACE_ROOT/ace/config.h \
    # && echo "workspace {\n\$(TAO_ROOT)/TAO_ACE.mwc\n\$(TAO_ROOT)/tests/Hello\n" >> $TRAVIS_BUILD_DIR/travis.mwc \
    # && echo "\$(CIAO_ROOT)/CIAO_TAO_DAnCE.mwc\n" >> $TRAVIS_BUILD_DIR/dds_env.mwc \
    # && echo "}\n" >> $TRAVIS_BUILD_DIR/dds_env.mwc \
    # && echo "ccm_lw=1" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    # && echo "ccm_noevent=1" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    # && echo "no_deprecated=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    # && echo "inline=0\noptimize=0\nxerces3=1\nssl=1\nipv6=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    # && echo "xerces3=1\nssl=1\n" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    # && echo "c++11=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    # && echo "include \$(ACE_ROOT)/include/makeinclude/platform_linux.GNU" >>
    # $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    # && echo "include \$(ACE_ROOT)/include/makeinclude/platform_linux_clang.GNU" >>
    # $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    # && cat dds_env.mwc \
    # && cat $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    # && cat $ACE_ROOT/ace/config.h \
    # && cat $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    # && perl $ACE_ROOT/bin/mwc.pl -type gnuace -workers 6 dds_env.mwc \
    # && make -j$(nproc) \
    # && mkdir -pv ${DDS_INSTALL_DIR}/DAnCE \
    # && INSTALL_PREFIX=${DDS_INSTALL_DIR}/DAnCE make install

RUN cd /tmp \
    && GIT_SSL_NO_VERIFY=1 git clone --depth=1 --recurse-submodules https://github.com/wireshark/wireshark.git

ENV CMAKE_PREFIX_PATH=${QTDIR}:${CMAKE_PREFIX_PATH}

# RUN cd /tmp \
    # && cd wireshark \
    # && cmake -E make_directory wireshark-build \
    ## && cmake -E chdir wireshark-build cmake .. -DCMAKE_PREFIX_PATH=${PREFIX_PATH} \
    ## && export CMAKE_PREFIX_PATH=${QTDIR}:${CMAKE_PREFIX_PATH} \
    # && cmake -E chdir wireshark-build cmake .. \
        # -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local \
        # -DCMAKE_INSTALL_DOCDIR=/usr/share/doc/wireshark \
        # -DDUMPCAP_INSTALL_OPTION=suid \
    # && make -C wireshark-build -j$(nproc) \
    # && make -C wireshark-build -j$(nproc) install\
    # cd /tmp \
    # rm -Rf wireshark

RUN mkdir -pv ${DDS_BASE_DIR} \
    && cd ${DDS_BASE_DIR} \
    && git clone --depth=1 --recurse-submodules https://github.com/DOCGroup/MPC.git \
    && git clone --depth=1 --recurse-submodules https://github.com/DOCGroup/ACE_TAO.git \
    && git clone --depth=1 --recurse-submodules https://github.com/DOCGroup/CIAO.git \
    && git clone --depth=1 --recurse-submodules https://github.com/DOCGroup/DAnCE.git \
    && git clone --depth=1 --recurse-submodules https://github.com/DOCGroup/XSC.git \
    && git clone --depth=1 --recurse-submodules https://github.com/objectcomputing/OpenDDS.git \
    && git clone --depth=1 --recurse-submodules https://github.com/omg-dds/dds-rtps.git \
    && git clone --depth=1 --recurse-submodules https://github.com/omg-dds/dds-xtypes.git \
    && git clone --depth=1 --recurse-submodules https://github.com/omg-dds/dds-security.git \
    && git clone --depth=1 https://github.com/RemedyIT/dancex11.git \
    && git clone --depth=1 https://github.com/RemedyIT/ciaox11.git

RUN cd ${DDS_BASE_DIR} \
    && cd XSC \
    && export ACE_TAO_ROOT=${DDS_BASE_DIR}/ACE_TAO \
    && export ACE_ROOT=$ACE_TAO_ROOT/ACE \
    && export TAO_ROOT=$ACE_TAO_ROOT/TAO \
    && export CIAO_ROOT=${DDS_BASE_DIR}/CIAO \
    && export DANCE_ROOT=${DDS_BASE_DIR}/DAnCE \
    && export MPC_ROOT=${DDS_BASE_DIR}/MPC \
    && export XSC_ROOT=${DDS_BASE_DIR}/XSC \
    && export LD_LIBRARY_PATH=$ACE_ROOT/lib:${XSC_ROOT}/XSC/utils:${XSC_ROOT}/lib:/usr/local/lib/:$LD_LIBRARY_PATH \
    && echo "#include \"ace/config-linux.h\"" >> $ACE_ROOT/ace/config.h \
    && echo "boost=1\nxsc=1\nxerces3=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    && echo "c++11=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    && echo "boost=1\nxerces3=1\nxsc=1\n" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    && echo "include \$(ACE_ROOT)/include/makeinclude/platform_linux.GNU" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    && cat $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    && cat $ACE_ROOT/ace/config.h \
    && cat $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    && perl $ACE_ROOT/bin/mwc.pl -type gnuace -workers 4 XSC.mwc \
    && mkdir -pv ${DDS_INSTALL_DIR}/XSC \
    && make -j$(nproc) \
    && INSTALL_PREFIX=${DDS_INSTALL_DIR}/XSC make install

RUN cd ${DDS_BASE_DIR}/OpenDDS \
    && ./configure --help \
    && export ACE_TAO_ROOT=${DDS_BASE_DIR}/ACE_TAO \
    && export ACE_ROOT=$ACE_TAO_ROOT/ACE \
    && export TAO_ROOT=$ACE_TAO_ROOT/TAO \
    && export CIAO_ROOT=${DDS_BASE_DIR}/CIAO \
    && export DANCE_ROOT=${DDS_BASE_DIR}/DAnCE \
    && export MPC_ROOT=${DDS_BASE_DIR}/MPC \
    && export XSC_ROOT=${DDS_BASE_DIR}/XSC \
    && export LD_LIBRARY_PATH=${DDS_BASE_DIR}/OpenDDS/lib:${DDS_BASE_DIR}/OpenDDS/build/target/lib:$ACE_ROOT/lib:$LD_LIBRARY_PATH \
    && export LD_LIBRARY_PATH=$ACE_ROOT/lib:${XSC_ROOT}/XSC/utils:${XSC_ROOT}/lib:/usr/local/lib/:$LD_LIBRARY_PATH \
    && ./configure --prefix=${DDS_INSTALL_DIR} \
            ${OPENDDS_BUILD_OPTIONS} \
            ${OPENDDS_BUILD_CONFIG_OPTIONS} \
            ${OPENDDS_SECURITY_OPTIONS} \
            ${OPENDDS_QT_OPTIONS} \
            --cmake=/opt/cmake/bin/ \
            --ace=$ACE_ROOT \
            --tao=$TAO_ROOT \
            --mpc=$MPC_ROOT \
            --mpcopts="-workers 4" \
            --features="uses_wchar=1" \
            --features="versioned_namespace=1" \
            --features="xerces3=1" \
            --features="ssl=1" \
            --macros="xerces3=1" \
            --macros="ssl=1" \
            --macros="c++11=1" \
            --macros="CPPFLAGS+=-Wno-deprecated -Wno-unused-result" \
            --macros="CPPFLAGS+=-Wno-deprecated-declarations -Wno-implicit-fallthroug -Wno-unused-result" \
            ### --configh="#define ACE_FACE_SAFETY_BASE" \
            ### --configh="#include \"ace/config-linux.h\"" \
    && ./tools/scripts/show_build_config.pl || true \
    && make -j$(nproc) \
    && make INSTALL_PREFIX=${DDS_INSTALL_DIR} install

    # && export LD_LIBRARY_PATH=:${LD_LIBRARY_PATH}:${pwd}/build/target/ACE_TAO/ACE/lib:${ACE_ROOT}/lib:${pwd}/build/target/lib:${pwd}/lib \
    # && echo -e "#include \"ace/config-linux.h\"" >> $ACE_ROOT/ace/config.h \
    # && echo -e "#define ACE_FACE_SAFETY_BASE" >> $ACE_ROOT/ace/config.h \
    # && echo -e "uses_wchar=1" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    # && echo -e "versioned_namespace=1" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    # && echo -e "xerces3=1\nssl=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    # && echo -e "inline=0\nipv6=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    # && echo -e "xerces3=1\nssl=1\n" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    # && echo -e "c++11=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    # && echo -e "include \$(ACE_ROOT)/include/makeinclude/platform_linux.GNU" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \

# RUN cd ${DDS_BASE_DIR} \
    # && git clone --depth=1 --recursive https://github.com/objectcomputing/mFAST.git \
    # && cd mFAST \
    # && cmake -E make_directory build \
    # && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=${DDS_INSTALL_DIR}  \
    # && cmake --build build --target all --clean-first > /dev/null 2>&1 \
    # && cmake --build build --target install > /dev/null 2>&1 \
    # && cd ${DDS_BASE_DIR}

#######ENV export CMAKE_INSTALL_PREFIX=/usr/
# ENV ACE_TAO_ROOT=${DDS_BASE_DIR}/ACE_TAO \
    # ACE_ROOT=$ACE_TAO_ROOT/ACE \
    # TAO_ROOT=$ACE_TAO_ROOT/TAO \
    # CIAO_ROOT=${DDS_BASE_DIR}/CIAO \
    # DANCE_ROOT=${DDS_BASE_DIR}/DAnCE \
    # MPC_ROOT=${DDS_BASE_DIR}/MPC \
    # XSC_ROOT=${DDS_BASE_DIR}/XSC \
    # LD_LIBRARY_PATH=${DDS_BASE_DIR}/OpenDDS/lib:${DDS_BASE_DIR}/OpenDDS/build/target/lib:$ACE_ROOT/lib:$LD_LIBRARY_PATH \
    # LD_LIBRARY_PATH=$ACE_ROOT/lib:${XSC_ROOT}/XSC/utils:${XSC_ROOT}/lib:/usr/local/lib/:$LD_LIBRARY_PATH  \
    # PATH="${PATH}:${ACE_ROOT}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

#ENV ACE_ROOT=${DDS_INSTALL_DIR}/ace \
#    TAO_ROOT=${DDS_INSTALL_DIR}/tao \
#    DDS_ROOT=${DDS_INSTALL_DIR}/dds \
#    PATH=".:${PATH}:${DDS_INSTALL_DIR}/ace/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

#RUN cd ${DDS_BASE_DIR} \
#    && git clone https://github.com/objectcomputing/liquibook.git \
#    && cd liquibook/ \
#    && git submodule init \
#    && git submodule update \
#    &&  . ./env.sh \
#    && mwc.pl -type make liquibook.mwc \
#    && make depend \
#    && make all



ARG ACCOUNT=${ACCOUNT:-developer}
RUN adduser --system --home /home/${ACCOUNT} --shell /bin/bash \
    --gecos GECOS --group --disabled-password --quiet ${ACCOUNT}
USER $ACCOUNT
WORKDIR /home/$ACCOUNT

CMD ["/bin/bash"]
