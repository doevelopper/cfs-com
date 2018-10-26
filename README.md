# DDS Abstraction Library 
Each DDS implementation can do everything we ask for (and even more), but it will not show you how to achieve that. 
DDS AL Library sits on top of common DDS implementation and do initializes the runtime environment, 
loads the classes, creates the domain participants...
## Introduction

There are a number of different DDS implementations available.
Many project are always DDS-dependent.Unfortunatly , instead of relying
on one implementtaion of DDS (put all our eggs in one basket), it is sometimes 
necessary to use a different implementation. If a huge amount pof code has been alredy developped
DDS abstraction layer helps to have less significant changes.

It aims to use
- [ ]  RTI Connext DDS
- [ ]  PrismTech OpenSplice DDS
- [ ]  OpenDDS
- [ ]  Twin Oaks Computing CoreDX DDS
- [ ]  eProsima Fast-RTPS

by providing

- Creating Topics in Partitions of the GDS (Global Data Space)
- Subscribing to these Topics via Listeners (and of course via DataReader instances)
- Publishing Events to these Topics via a DataWriter instance
- Handling QoS

## Requirements

### Dependencies

```sh
    >$ sudo apt-get install bison flex gsoap build-essential gawk libgcrypt20-dev libcrypto++-dev \
                   mesa-common-dev libglu1-mesa-dev libpcap-dev
```
#### xerces

```sh
    >$ wget http://www-us.apache.org/dist//xerces/c/3/sources/xerces-c-3.2.1.tar.gz
    >$ tar -xvzf xerces-c-3.2.1.tar.gz
    >$ cd xerces-c-3.2.1/
    >$ ./configure --prefix=${HOME}/dds_install --enable-static --enable-shared --enable-netaccessor-socket \
                   --enable-transcoder-gnuiconv --enable-transcoder-iconv --enable-msgloader-inmemory \
                   --enable-xmlch-uint16_t --enable-xmlch-char16_t
```
#### QT 

```sh
    >$ export CMAKE_PREFIX_PATH=/opt/Qt5.11.0/5.11.0/gcc_64:$CMAKE_PREFIX_PATH
    >$ export QTDIR=/opt/Qt5.12.0/5.11.0/gcc_64
```

#### Wireshark for using Opendds Dissector 

```sh
    >$ git clone --depth 1 https://code.wireshark.org/review/p/wireshark.git
    >$ cmake -E make_directory build
    >$ cmake -E chdir build cmake -DCMAKE_INSTALL_PREFIX=${HOME}/dds_install/wireshark ..
    >$ cmake --build build --target install
```

#### Bulding Eproxima DDS
```sh
    >$ git clone --depth 1 https://github.com/eProsima/Fast-RTPS.git
    >$ cd Fast-RTPS
    >$ cmake -E make_directory build
    >$ cmake -E chdir build cmake -DCMAKE_INSTALL_PREFIX=${HOME}/dds_install/fats_rtps  -DTHIRDPARTY=ON ..
    >$ cmake --build build --target install
```

#### Building Opendds QT Support
##### Without JAVA suport
```sh
    >$ ./configure --prefix=home/happyman/dds_install/opendds \
         -std=c++11 --static --ipv6 --rapidjson --glib --qt --no-tests --boost \
         --xerces3=${HOME}/dds_install
```
##### With JAVA suport and   QT Support  (Remove --static flag)
```sh
    >$ ./configure --prefix=${HOME}/dds_install/opendds -std=c++11 --verbose  \
        --ipv6 --rapidjson --no-tests --boost --xerces3=${HOME}/dds_install \
        --java  --glib --qt [--safety-profile]
```

##### Building Opendds QT SupportW ireSharck (cmake build) and java
```sh
    >$ ./configure --prefix=${HOME}/dds_install/opendds -std=c++11 --verbose  \
        --ipv6 --rapidjson --java  --glib -qt \
        --no-tests --boost --xerces3=${HOME}/dds_install \ 
        --wireshark_build=<wireshark-src/build>  \ 
        --wireshark_lib=<wireshark-src/build>
    >$ make && make install
    >$ cp -a <OpenDDS_DIR>/ACE_wrappers/MPC /usr/local/share/ace/MPC
```

##### Specific to Opendds \[3.13.x,...\] using latest ACE/TAO/MPC from GitHub
```sh
./configure --prefix=/opt/dds/opendds-dev/ -std=c++11 --ipv6 \
    --ace=${HOME}/Downloads/ACE_TAO/ACE \
	--tao=${HOME}/Downloads/ACE_TAO/TAO --mpc=${HOME}/Downloads/MPC \
	--openssl --xerces3=${HOME}/dds_install --rapidjson --glib --boost \
    --security --safety-profile=base --gtest=${HOME}/dds_install \
	--qt=/opt/Qt5.11.2/5.11.2/gcc_64
```
Or simply
```sh
./configure --prefix=/opt/dds/opendds-dev/ -std=c++11 --ipv6 \
	--openssl --xerces3=${HOME}/dds_install --rapidjson --glib --boost \
    --security --safety-profile=base --gtest=${HOME}/dds_install \
    --qt=/opt/Qt5.11.2/5.11.2/gcc_64 --no-tests 
    --ace-github-latest
```
#### Prismtech OpenSPlice DDS 
```text
   Defaul openFusion ORB is used by OpenSPlice SPLICE_ORB=DDS_OpenFusion_1_6_1
   sourcing in <OpenDDS/dir>/setenv.sh will set following variabels
   ...
   export GLIB_LIB_DIR=lib/x86_64-linux-gnu
   export CIAO_ROOT=unused
   export TAO_ROOT=<...>/ACE_wrappers/TAO
   export DDS_ROOT=<...>
   export XERCESCROOT=<...>
   export DANCE_ROOT=unused
   export ACE_ROOT=<...>/ACE_wrappers
   export BOOST_ROOT=<...>
   export GLIB_ROOT=<...>
   export MPC_ROOT=<...>

   unfortunatly SPLICE_ORB=DDS_ACE_TAO_x_y_z and the compilation of opensplice will fail
```

```sh
    >$ git clone  --depth 1 https://github.com/ADLINK-IST/opensplice.git vortex-opensplice
    >$ cd vortex-opensplice
    >$ ./configure x86_64.linux-release --prefix=${HOME}/dds_install/opensplice
    >$  source envs-x86_64.linux-dev.sh
    >$  make
```

```text
    Necessary will be available in
    1. Vortex/OpenSplice/src/dir>/install/HDE/x86_64.linux/ (All components for the Host Development Hnvironment)
    2. Vortex/OpenSplice/src/dir>/install/RTS/x86_64.linux/ (All components for the Runtime System)
    3. Vortex/OpenSplice/src/dir>/install/VC/x86_64.linux/  (Virtual Carriers with installation support)
```

## Interactive Data Language


##  Domain Participant Factory


## Domain participant


## Type registration


## Topic


## Content Filtered Topic

## Publisher


## Subscriber

## Data Writer

### Interface

### Generic interface

### Specific interface

## Data Reader

### Interface

### Generic interface

### Specific interface

## Exemple

### Instance Registration

### Write

### Reada

## Xml Object Over DDS

## Data Reader Callbacks

### Read Condition

### Wait Set

### Synchronous Callback Manager

### Data Callback Listener

### Data Callback Data Reader

#Disclaimer
Of course, as it is only an abstraction (and we're not stating that we would've created a better solution 
for the problem than Vortex itself) it can do way less than what the OpenSplice DDS is capable of, 
but for what we need it, it is perfect.


