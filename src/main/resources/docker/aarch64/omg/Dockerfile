



export PATH=$ARM_BIN:$PATH

git clone ace_tao
cd $ACE_ROOT/ace
echo "#include \"ace/config-linux.h\"" > config.h
cd $ACE_ROOT/include/makeinclude
echo -e "ARM=1\nCROSS_COMPILE=\$(LOCAL_CROSS_PREFIX)\ninclude \$(ACE_ROOT)/include/makeinclude/platform_linux.GNU" > platform_macros.GNU
echo "Configuring ACE for ARM"
echo "#include \"ace/config-linux.h\"" > $ACE_ROOT/ace/config.h
echo "CROSS_COMPILE=$ARM_PREFIX" > $ACE_ROOT/include/makeinclude/platform_macros.GNU
echo "no_hidden_visibility=1" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU
echo versioned_so=0 >> $ACE_ROOT/include/makeinclude/platform_macros.GNU
echo OCFLAGS=-Os >> $ACE_ROOT/include/makeinclude/platform_macros.GNU
echo cross_compile=1 >> $ACE_ROOT/include/makeinclude/platform_macros.GNU
echo ARM=1 >> $ACE_ROOT/include/makeinclude/platform_macros.GNU
echo "include \$(ACE_ROOT)/include/makeinclude/platform_linux.GNU" >> $ACE_ROOT/include/makeinclude/platform_macros.GNU

cd $ACE_ROOT/ace
perl $ACE_ROOT/bin/mwc.pl -type gnuace ace.mwc
make -j $CORES


RUN cd pi-opendds && \
  ./configure --prefix=${OPENDDS_PREFIX} \
    --ace-github-latest \
    --security --no-tests --target=linux-cross \
    --target-compiler=arm-linux-gnueabihf-g++ \
    --openssl=${BUILD_ROOT}/pi-openssl/usr/local \
    --xerces3=${BUILD_ROOT}/pi-xerces
    && make -j${OPENDDS_MAKE_JOBS}

