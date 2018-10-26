# Find a OpenDDS implementation.
#
# The following directories are searched:
# OpenDDS_ROOT (CMake variable)
# OpenDDS_ROOT (Environment variable)
# NDDSHOME (Environment variable)
#
# Prior to calling this script, you may set the OpenDDS_HOST variable. This is used
# when searching for some implementations as a name for the directory
# containing the library files. For example, it could be set to
# "x64Linux2.6gcc4.1.1".
#
# This sets the following variables:
# OpenDDS_FOUND - True if DDS was found.
# OpenDDS_VENDOR - Name of the DDS vendor found (e.g. "RTI")
# OpenDDS_INCLUDE_DIRS - Directories containing the DDS include files.
# OpenDDS_LIBRARIES - Libraries needed to use DDS.
# OpenDDS_DEFINITIONS - Compiler flags for DDS.
# OpenDDS_VERSION - The version of DDS found.
# OpenDDS_VERSION_MAJOR - The major version of DDS found.
# OpenDDS_VERSION_MINOR - The minor version of DDS found.
# OpenDDS_VERSION_PATCH - The revision version of DDS found.
# OpenDDS_VERSION_CAN - The candidate version of DDS found.

#find_path(DDS_INCLUDE_DIR dds
#    HINTS ${DDS_ROOT} $ENV{DDS_ROOT}
#)

#find_path(ACE_INCLUDE_DIR ace
#    HINTS ${ACE_ROOT} $ENV{ACE_ROOT}
#)

#find_path(TAO_INCLUDE_DIR tao
#    HINTS ${ACE_ROOT}/TAO $ENV{ACE_ROOT}/TAO
#)

set(DDS_ROOT "$ENV{HOME}/Documents/OpenDDS-DDS-3.12.2")

find_path(OpenDDS_INCLUDE_DIR dds/DdsDcpsS.h
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/include 
        ${CMAKE_INSTALL_PREFIX}/opendds/include 
        ${DDS_ROOT}/include 
  $ENV{DDS_ROOT}/include
    DOC "OpenDDs header"
)

find_program(OPENDDS_IDL opendds_idl
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/bin
        ${CMAKE_INSTALL_PREFIX}/opendds/bin
        ${DDS_ROOT}/bin
        $ENV{DDS_ROOT}/bin
    DOC "Opend DDS IDL executable."
)

find_program(TAO_PENDDS_IDL tao_idl
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/bin
        ${CMAKE_INSTALL_PREFIX}/opendds/bin
        ${DDS_ROOT}/bin
        $ENV{DDS_ROOT}/bin
    DOC "TAO DDS IDL executable."
)

find_library(OPENDDS_DCPS_LIBRARY
    NAMES 
        libOpenDDS_Dcps OpenDDS_Dcps 
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev
        ${CMAKE_INSTALL_PREFIX}/opendds
        ${DDS_ROOT}
        $ENV{DDS_ROOT}
    PATH_SUFFIXES 
        lib
    DOC 
        "OpenDDS Data centric publisher subscriber"
    NO_CMAKE_SYSTEM_PATH
    NO_DEFAULT_PATH
)
message (STATUS "OPENDDS_DCPS_LIBRARY ${OPENDDS_DCPS_LIBRARY}")

find_library(ACE_OPENDDS_DCPS_LIBRARY
    NAMES
        libACE ACE
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "ACE Library"
)
# message (STATUS "ACE_OPENDDS_DCPS_LIBRARY ${ACE_OPENDDS_DCPS_LIBRARY}")
find_library(ACE_XML_OPENDDS_DCPS_LIBRARY
    NAMES
        libACE_XML_Utils ACE_XML_Utils
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "ACE XML Library"
)

find_library(FACE_OPENDDS_DCPS_LIBRARY
    NAMES
        libOpenDDS_FACE OpenDDS_FACE
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "Future Airborne Capability Environment (FACE) Library"
)


find_library(FEDERATOR_OPENDDS_DCPS_LIBRARY
    NAMES
        libOpenDDS_Federator OpenDDS_Federator
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS Federator"
)

find_library(INFOREPODISCOVERY_OPENDDS_DCPS_LIBRARY
    NAMES
        libOpenDDS_InfoRepoDiscovery OpenDDS_InfoRepoDiscovery
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS Info Repo Discovery"
)

find_library(INFOREPODISCOVERY_OPENDDS_DCPS_LIBRARY
    NAMES
        libOpenDDS_InfoRepoLib OpenDDS_InfoRepoLib
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS Info Repo Lib"
)

find_library(INFOREPODISCOVERY_OPENDDS_DCPS_LIBRARY
    NAMES
        libOpenDDS_InfoRepoServ OpenDDS_InfoRepoServ
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS Info Repo Serv"
)

find_library(INFOREPODISCOVERY_OPENDDS_DCPS_LIBRARY
    NAMES
        libOpenDDS_Model OpenDDS_Model
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS Model "
)


find_library(MONITOR_OPENDDS_DCPS_LIBRARY
    NAMES
        libOpenDDS_monitor OpenDDS_monitor
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS monitor "
)

find_library(MONITOR_OPENDDS_DCPS_LIBRARY
    NAMES
        libOpenDDS_Multicast OpenDDS_Multicast
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS Multicast"
)

find_library(OPENDDS_QOS_XML_XSC_HANDLER_OPENDDS_DCPS_LIBRARY
    NAMES
        libOpenDDS_QOS_XML_XSC_Handler OpenDDS_QOS_XML_XSC_Handler
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS QOS XML XSC Handler"
)

find_library(RTPS_OPENDDS_DCPS_LIBRARY
    NAMES
        libOpenDDS_Rtps OpenDDS_Rtps
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS Rtps"
)


find_library(RTPS_UDP_OPENDDS_DCPS_LIBRARY
    NAMES
        libOpenDDS_Rtps_Udp OpenDDS_Rtps_Udp
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS Rtps Udp"
)


find_library(SHMEM_OPENDDS_DCPS_LIBRARY
    NAMES
        libOpenDDS_Shmem.so OpenDDS_Shmem
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS Shmem"
)

find_library(TCP_OPENDDS_DCPS_LIBRARY
    NAMES
        libOpenDDS_Tcp OpenDDS_Tcp
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS Tcp"
)


find_library(UDP_OPENDDS_DCPS_LIBRARY
    NAMES
        libOpenDDS_Udp libOpenDDS_Udp
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS Udp"
)

find_library(TAO_ANYTYPECODE_OPENDDS_DCPS_LIBRARY
    NAMES
        libTAO_AnyTypeCode TAO_AnyTypeCode
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS TAO Any Type Code"
)

find_library(TAO_ASYNC_IORTABLE_OPENDDS_DCPS_LIBRARY
    NAMES
        libTAO_Async_IORTable TAO_Async_IORTable
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS TAO Async IOR Table"
)


find_library(TAO_BIDIRGIOP_OPENDDS_DCPS_LIBRARY
    NAMES
        libTAO_BiDirGIOP TAO_BiDirGIOP
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS TAO BiDir GIOP"
)


find_library(TAO_CODECFACTORY_OPENDDS_DCPS_LIBRARY
    NAMES
        libTAO_CodecFactory TAO_CodecFactory
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS TAO Codec Factory "
)

find_library(TAO_CODESET_OPENDDS_DCPS_LIBRARY
    NAMES
        libTAO_Codeset TAO_Codeset
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS TAO Codeset"
)

find_library(TAO_CSD_FRAMEWORK_OPENDDS_DCPS_LIBRARY
    NAMES
        libTAO_CSD_Framework TAO_CSD_Framework
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS TAO CSD Framework "
)


find_library(TAO_CSD_THREADPOOL_OPENDDS_DCPS_LIBRARY
    NAMES
        libTAO_CSD_ThreadPool TAO_CSD_ThreadPool
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS TAO CSD ThreadPool"
)

find_library(TAO_DYNAMICINTERFACE_OPENDDS_DCPS_LIBRARY
    NAMES
        libTAO_DynamicInterface TAO_DynamicInterface
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS TAO DynamicInterface"
)

find_library(TAO_IDL_BE_OPENDDS_DCPS_LIBRARY
    NAMES
        libTAO_IDL_BE TAO_IDL_BE
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS TAO IDL BE"
)

find_library(TAO_IDL_FE_OPENDDS_DCPS_LIBRARY
    NAMES
        libTAO_IDL_FE TAO_IDL_FE
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS TAO IDL FE"
)

find_library(TAO_IMR_CLIENT_OPENDDS_DCPS_LIBRARY
    NAMES
        libTAO_ImR_Client TAO_ImR_Client
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS TAO ImR Client"
)

find_library(TAO_IORMANIP_OPENDDS_DCPS_LIBRARY
    NAMES
        libTAO_IORManip TAO_IORManip
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS TAO IOR Manip"
)

find_library(TAO_IORTABLE_OPENDDS_DCPS_LIBRARY
    NAMES
        libTAO_IORTable TAO_IORTable
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS TAO_IORTABLE"
)

find_library(TAO_MESSAGING_OPENDDS_DCPS_LIBRARY
    NAMES
        libTAO_Messaging TAO_Messaging
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS TAO Messaging"
)

find_library(TAO_PI_OPENDDS_DCPS_LIBRARY
    NAMES
        libTAO_PI TAO_PI
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS TAO_PI"
)

find_library(TAO_PORTABLESERVER_OPENDDS_DCPS_LIBRARY
    NAMES
        libTAO_PortableServer TAO_PortableServer
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS TAO Portable Server"
)

find_library(TAO_OPENDDS_DCPS_LIBRARY
    NAMES
        libTAO TAO
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS TAO"
)

find_library(TAO_SVC_UTILS_OPENDDS_DCPS_LIBRARY
    NAMES
        libTAO_Svc_Utils TAO_Svc_Utils
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS TAO Svc Utils"
)

find_library(TAO_VALUETYPE_OPENDDS_DCPS_LIBRARY
    NAMES
        libTAO_Valuetype TAO_Valuetype
    HINTS
        ${CMAKE_INSTALL_PREFIX}/opendds-dev/lib
        ${CMAKE_INSTALL_PREFIX}/opendds/lib
        ${DDS_ROOT}/lib
        $ENV{DDS_ROOT}/lib
    DOC "OpenDDS TAO Valuetype"
)

mark_as_advanced(
    OpenDDS_INCLUDE_DIR
    OPENDDS_IDL 
    TAO_OPENDDS_IDL
    OPENDDS_DCPS_LIBRARY
  # ACE_OPENDDS_DCPS_LIBRARY
  # ACE_XML_OPENDDS_DCPS_LIBRARY
  # FACE_OPENDDS_DCPS_LIBRARY
  # FEDERATOR_OPENDDS_DCPS_LIBRARY
  # INFOREPODISCOVERY_OPENDDS_DCPS_LIBRARY
  # INFOREPODISCOVERY_OPENDDS_DCPS_LIBRARY
  # INFOREPODISCOVERY_OPENDDS_DCPS_LIBRARY
  # INFOREPODISCOVERY_OPENDDS_DCPS_LIBRARY
  # MONITOR_OPENDDS_DCPS_LIBRARY
  # MONITOR_OPENDDS_DCPS_LIBRARY
  # OPENDDS_QOS_XML_XSC_HANDLER_OPENDDS_DCPS_LIBRARY
  # RTPS_OPENDDS_DCPS_LIBRARY
  # RTPS_UDP_OPENDDS_DCPS_LIBRARY
  # SHMEM_OPENDDS_DCPS_LIBRARY
  # TCP_OPENDDS_DCPS_LIBRARY
  # UDP_OPENDDS_DCPS_LIBRARY
  # TAO_ANYTYPECODE_OPENDDS_DCPS_LIBRARY
  # TAO_ASYNC_IORTABLE_OPENDDS_DCPS_LIBRARY
  # TAO_BIDIRGIOP_OPENDDS_DCPS_LIBRARY
  # TAO_CODECFACTORY_OPENDDS_DCPS_LIBRARY
  # TAO_CODESET_OPENDDS_DCPS_LIBRARY
  # TAO_CSD_FRAMEWORK_OPENDDS_DCPS_LIBRARY
  # TAO_CSD_THREADPOOL_OPENDDS_DCPS_LIBRARY
  # TAO_DYNAMICINTERFACE_OPENDDS_DCPS_LIBRARY
  # TAO_IDL_BE_OPENDDS_DCPS_LIBRARY
  # TAO_IDL_FE_OPENDDS_DCPS_LIBRARY
  # TAO_IMR_CLIENT_OPENDDS_DCPS_LIBRARY
  # TAO_IORMANIP_OPENDDS_DCPS_LIBRARY
  # TAO_IORTABLE_OPENDDS_DCPS_LIBRARY
  # TAO_MESSAGING_OPENDDS_DCPS_LIBRARY
  # TAO_PI_OPENDDS_DCPS_LIBRARY
  # TAO_PORTABLESERVER_OPENDDS_DCPS_LIBRARY
  # TAO_OPENDDS_DCPS_LIBRARY
  # TAO_SVC_UTILS_OPENDDS_DCPS_LIBRARY
)

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(OPENDDS_LIBS DEFAULT_MSG 
    OpenDDS_INCLUDE_DIR
    OPENDDS_DCPS_LIBRARY
    OPENDDS_IDL 
#    TAO_OPENDDS_IDL
)

