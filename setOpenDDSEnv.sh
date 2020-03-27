
#!/bin/bash

#/opt/dds/opendds/share/ace/ace-devel.sh
#/opt/dds/opendds/share/tao/tao-devel.sh
#/opt/dds/opendds/share/dds/dds-devel.sh

export ACE_ROOT=/opt/dds/opendds/share/ace
export TAO_ROOT=/opt/dds/opendds/share/tao
export DDS_ROOT=/opt/dds/opendds/share/dds
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/dds/opendds/lib
export CPATH=$CPATH:/opt/dds/opendds/include
export SSL_ROOT=/usr/local
export BOOST_ROOT=/usr/local
export GLIB_ROOT=/usr
export XERCESCROOT=/usr/local
export PROTOBUF_HOME=/usr/local
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${ACE_ROOT}/tao:${ACE_ROOT}/lib:${ACE_ROOT}/TAO/orbsvcs:${MPC_ROOT}:${CIAO_ROOT}:${DANCE_ROOT}:${DDS_ROOT}

#export C_INCLUDE_PATH=$C_INCLUDE_PATH:/opt/dds/opendds/include
#export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/opt/dds/opendds/include
#export LDFLAGS="-L/opt/dds/opendds/lib"
#export CFLAGS="-I/opt/dds/opendds/include"
#export PATH=$PATH:/opt/dds/opendds/bin:/opt/dds/opendds/share/ace/bin:/opt/dds/opendds/share/dds/bin:

#DDS_ROOT=/tmp/OpenDDS
#QT5_INCDIR=/opt/Qt/5.14.1/gcc_64/include
#QT5_LIBDIR=/opt/Qt/5.14.1/gcc_64/lib
#TAO_ROOT=/tmp/ACE_TAO/TAO
#LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/Qt/5.14.1/gcc_64/lib:/tmp/ACE_TAO/ACE/lib:/tmp/OpenDDS/lib:/usr/local/bin
#JAVA_PLATFORM=linux
#MPC_ROOT=/tmp/MPC
#QT5_SUFFIX=
#PATH=${PATH}:/tmp/ACE_TAO/ACE/bin:/tmp/OpenDDS/bin
#DANCE_ROOT=unused
#QTDIR=/opt/Qt/5.14.1/gcc_64
#QT5_BINDIR=/opt/Qt/5.14.1/gcc_64/bin
#GLIB_LIB_DIR=lib/x86_64-linux-gnu
#ACE_ROOT=/tmp/ACE_TAO/ACE
#RAPIDJSON_ROOT=/tmp/OpenDDS/tools/rapidjson
#JAVA_HOME=/opt/jdk1.8.0_212
#CIAO_ROOT=unused

