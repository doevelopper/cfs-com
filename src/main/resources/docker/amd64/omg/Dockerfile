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

FROM doevelopper/cfs-com-dev:latest

USER root

#ENV ACE_TAO_ROOT=/tmp/ACE_TAO
#ENV ACE_ROOT=$ACE_TAO_ROOT/ACE
#ENV TAO_ROOT=$ACE_TAO_ROOT/TAO
#ENV CIAO_ROOT=/tmp/CIAO
#ENV DANCE_ROOT=/tmp/DAnCE
#ENV MPC_ROOT=/tmp/MPC
#ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$ACE_ROOT/lib:$LD_LIBRARY_PATH

RUN cd /tmp \
    && mkdir -pv build_dir \
    && export ACE_TAO_ROOT=/tmp/build_dir/ACE_TAO \
    && export ACE_ROOT=$ACE_TAO_ROOT/ACE \
    && export MPC_ROOT=/tmp/build_dir/MPC \
    && cd build_dir \
    && git clone --depth=1 https://github.com/DOCGroup/MPC.git \
    && git clone --depth=1 git://github.com/DOCGroup/ACE_TAO.git \
    && git clone --depth=1 https://github.com/DOCGroup/XSC.git \
    && echo -e "#include \"ace/config-linux.h\"" >> $ACE_ROOT/ace/config.h \
    && echo -e "boost=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    && echo -e "c++11=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    && echo -e "xsc=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    && echo -e "xerces3=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    && echo -e "c++11=1\n" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU \
    && echo -e "boost=1\n" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    && echo -e "xerces3=1\n" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    && echo -e "xsc=1\n" >> $ACE_ROOT/bin/MakeProjectCreator/config/default.features \
    && echo -e "include \$(ACE_ROOT)/include/makeinclude/platform_linux.GNU" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU

RUN cd /tmp \
    && export ACE_ROOT=/tmp/build_dir/ACE_TAO/ACE/ \
    && export MPC_ROOT=/tmp/build_dir/MPC \
    && cd build_dir/XSC \
    && perl $ACE_ROOT/bin/mwc.pl -type gnuace -workers 2 XSC.mwc \
    && mkdir -pv /opt/XSC \
    && make  `nproc` \
    && DESTDIR=/opt/XSC make install

ENV OPENDDS_BUILD_OPTIONS="-std=c++11 --ipv6 --openssl --xerces3=/usr/local --java --rapidjson --glib --boost=/usr"
ENV OPENDDS_BUILD_CONFIG_OPTIONS="--no-tests --no-inline --features=versioned_namespace=1 --macros=c++11=1 --no-debug --optimize"
ENV DDS_BUILD_CONFIG_OPTIONS="--security --safety-profile=base --cmake=/opt/cmake/bin/"
ENV DDS_SAFETY_BASE_NO_BUILTIN_TOPICS="--safety-profile=base --no-built-in-topics"
ENV DDS_SECURITY="--security --features=versioned_namespace=1"
ENV DDS_WITHOUTFEATURES "--no-inline --no-debug --no-built-in-topics --no-content-subscription --no-ownership-profile --no-object-model-profile --no-persistence-profile --security"
ENV DDS_BUILD_MACRO="--macros=c++11=1"
ENV DDS_BUILD_MACRO_1="--macros=CPPFLAGS+=-Wno-deprecated -Wno-unused-result"
ENV DDS_BUILD_MACRO_2="--macros=CPPFLAGS+=-Wno-deprecated-declarations -Wno-implicit-fallthroug -Wno-unused-result"
ENV DDS_BUILD_SECURITY_OPTIONS="--security --safety-profile=base"
ENV DDS_BUILD_QT_OPTIONS="--qt --wireshark=/usr/include/wireshark/"

ARG GET_DDS_REPO="https://github.com/objectcomputing/OpenDDS.git"
ARG GET_DDS_VERSION="DDS-3.13"

RUN git config --global url."https://github.com/".insteadOf "git@github.com:"
RUN git config --global url."https://".insteadOf git://


#RUN cd /tmp \
#    && git clone --depth=1 --recurse-submodules https://github.com/DOCGroup/MPC.git \
#    && git clone --depth=1 --recurse-submodules https://github.com/DOCGroup/ACE_TAO.git \
#    && git clone --depth=1 --recurse-submodules https://github.com/DOCGroup/CIAO.git \
#    && git clone --depth=1 --recurse-submodules https://github.com/DOCGroup/DAnCE.git \
#    && git clone --depth=1 --recurse-submodules https://github.com/objectcomputing/OpenDDS.git \
#    && export ACE_TAO_ROOT=/tmp/ACE_TAO \
#    && export ACE_ROOT=$ACE_TAO_ROOT/ACE \
#    && export TAO_ROOT=$ACE_TAO_ROOT/TAO \
#    && export CIAO_ROOT=/tmp/CIAO \
#    && export DANCE_ROOT=/tmp/DAnCE \
#    && export MPC_ROOT=/tmp/MPC \
#    && export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$ACE_ROOT/lib:$LD_LIBRARY_PATH \
#    && cd OpenDDS \
#    && ./configure --help \
#    && ./configure --prefix=/usr/local \
#            ${OPENDDS_BUILD_OPTIONS} \
#            ${OPENDDS_BUILD_CONFIG_OPTIONS} \
#            ${DDS_SECURITY} \
#            --cmake=/opt/cmake/bin/ \
#			--ace=$ACE_ROOT \
#			--tao=$TAO_ROOT \
#			--mpc=$MPC_ROOT \
#			--mpcopts="-workers 4" --features=uses_wchar=1 \
#    && ./tools/scripts/show_build_config.pl || true \
#    && make -j `nproc` \
#    && make install

#ENV ACE_ROOT=/usr/local/share/ace \
#    TAO_ROOT=/usr/local/share/tao \
#    DDS_ROOT=/usr/local/share/dds \
#    LD_LIBRARY_PATH=$ACE_ROOT/lib:$LD_LIBRARY_PATH \
#    PATH="${PATH}:/usr/local/share/ace/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"


#RUN cd /tmp \
#    &&  git clone  --depth=1 --recurse-submodules https://github.com/omg-dds/dds-security.git \
#    && cd dds-security


#RUN cd /tmp \
#    && git clone  --depth=1 --recurse-submodules  https://github.com/omg-dds/dds-rtps.git
#    && git clone  --depth=1 --recurse-submodules  https://github.com/omg-dds/dds-xtypes.git


#RUN cd /tmp \
#    &&  git clone  --depth=1 --recurse-submodules ${GET_DDS_REPO} \
#    && cd OpenDDS \
#    && ./configure --help \
#    && ./configure $OPENDDS_BUILD_OPTIONS  $OPENDDS_BUILD_CONFIG_OPTIONS $DDS_BUILD_CONFIG_OPTIONS \
#        $DDS_BUILD_MACRO $DDS_BUILD_MACRO_1 $DDS_BUILD_MACRO_2 \
#        --mpcopts="-workers 4" --ace-github-latest \
#        --prefix=/usr/opendds \
#    && ./tools/scripts/show_build_config.pl \
#    && export LD_LIBRARY_PATH=:${LD_LIBRARY_PATH}:${pwd}/build/target/ACE_TAO/ACE/lib:${ACE_ROOT}/lib:${pwd}/build/target/lib:${pwd}/lib \
#    && make clean && make  -j `nproc` && make install \
#    && cd /tmp \
#    && rm -rvf OpenDDS

#RUN cd /tmp \
#    &&  git clone  --depth=1 --recurse-submodules ${GET_DDS_REPO} \
#    && cd OpenDDS \
#    && ./configure --help \
#    && ./configure $OPENDDS_BUILD_OPTIONS  $OPENDDS_BUILD_CONFIG_OPTIONS $DDS_BUILD_CONFIG_OPTIONS \
#        --mpcopts="-workers 4" --ace-github-latest \
#        --prefix=/usr \
#    && ./tools/scripts/show_build_config.pl \
#    && export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${pwd}/build/target/ACE_TAO/ACE/lib:${ACE_ROOT}/lib:${pwd}/build/target/lib:${pwd}/lib \
#    && make -j `nproc` && make install \
#    && cd /tmp \
#    && rm -rvf OpenDDS


#https://github.com/RemedyIT/dancex11.git
#https://github.com/RemedyIT/ciaox11.git
#    && export CMAKE_INSTALL_PREFIX=/usr/
#    && export QTDIR: /opt/Qt5.11.2/5.11.2/gcc_64

# RUN cd /tmp \
    # && git clone --depth=1 --recursive https://github.com/objectcomputing/mFAST.git \
    # && cd mFAST \
    # && cmake -E make_directory build \
    # && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local  \
    # && cmake --build build --target all --clean-first \
    # && cmake --build build --target install \
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
ENV ACCOUNT ${ACCOUNT:-doevelopper}
RUN chown -R $ACCOUNT:$ACCOUNT /home/$ACCOUNT
USER $ACCOUNT

WORKDIR /home/$ACCOUNT
CMD ["/bin/bash"]
