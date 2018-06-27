##############################################################################
# Try to find OpenSplice
# Once done this will define:
#
#  OpenSplice_FOUND - system has OpenSplice.
#  OpenSplice_INCLUDE_DIRS - the OpenSplice include directory.
#  OpenSplice_LIBRARIES - Link these to use OpenSplice.
#  OpenSplice_IDLGEN_BINARY - Binary for the IDL compiler.
#
# You need the environment variable $OSPL_HOME to be set to your OpenSplicea
# ie  export OSPL_HOME=vortexopenplice/install/HDE/x86_64.linux
# installation directory.
# This script also includes the MacroOpenSplice.cmake script, which is useful
# for generating code from your idl.
#

# We need NDDSHOME set to know the location of the RTI Connext DDS installation

if (NOT DEFINED NDDSHOME)
    if (DEFINED ENV{NDDSHOME})
        set(NDDSHOME $ENV{NDDSHOME})
    else()
        message(FATAL_ERROR "$NDDSHOME not specified. Please set -DNDDSHOME= to your RTI Connext DDS installation directory")
    endif()
endif()

# We need to know the RTI Connext DDS libraries to compile against
if (NOT DEFINED ARCHITECTURE)
    message(FATAL_ERROR "$ARCHITECTURE not specified. Please set -DARCHITECTURE= to your RTI Connext DDS architecture")
endif()

find_path(CONNEXTDDS_INCLUDE_DIRS
    NAMES 
        ndds/ndds_c.h
    PATHS ${NDDSHOME}/include
)

set(CONNEXTDDS_INCLUDE_DIRS
    ${NDDSHOME}/include
    ${CONNEXTDDS_INCLUDE_DIRS}
)

find_library(NDDS_CORE_LIBS
    NAMES 
        libnddscore nddscore
    PATHS 
        ${NDDSHOME}
    PATH_SUFFIXES 
        /lib/${ARCHITECTURE}
)

MARK_AS_ADVANCED(NDDS_CORE_LIBRARY)

find_library(NDDS_LIB
    NAMES 
        libnddsc nddsc
    PATHS 
         ${NDDSHOME}
    PATH_SUFFIXES 
        /lib/${ARCHITECTURE}
)


find_library(NDDS_CPP_LIB
    NAMES 
        libnddscpp nddscpp
    PATHS 
        ${NDDSHOME}
    PATH_SUFFIXES 
        /lib/${ARCHITECTURE}
)

set(CONNEXTDDS_LIBRARIES 
    ${nddscpplib}
    ${nddsclib}
    ${nddscorelib}
    ${CMAKE_DL_LIBS}
    "-ldl -lnsl -lm -lpthread -lrt"    
)

find_program ( RTI_CODE_DDSGEN RTIDDSGEN 
    HINTS
        "${NDDSHOME}/bin"
)

find_library(NDDS_CPP2_Z_LIB
    NAMES  
        nddscpp2z
    PATHS 
        "${CONNEXTDDS_DIR}/lib/${CONNEXTDDS_ARCH}"
)

find_library(NDDS_CPP2_LIB
    NAMES
        nddscpp2
    PATHS
        "${CONNEXTDDS_DIR}/lib/${CONNEXTDDS_ARCH}"
)


execute_process(COMMAND ${ RTI_CODE_DDSGEN} -version
    OUTPUT_VARIABLE RTI_CODE_GEN_VERSION_STR
)

string(REGEX MATCH "[0-9]+\\.[0-9]+\\.[0-9]+"
    RTI_CODE_GEN_VERSION ${RTI_CODE_GEN_VERSION_STR}
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(RTIConnexDDS DEFAULT_MSG
   REQUIRED_VARS 
       RTI_CODE_DDSGEN 
       CONNEXTDDS_INCLUDE_DIRS 
       CONNEXTDDS_LIBRARIES
       RTI_CODE_GEN_VERSION
   VERSION_VAR RTI_CODE_GEN_VERSION
)


if(NOT TARGET NDDS_CORE::NDDS_CORE)
    add_library(NDDS_CORE::NDDS_CORE UNKNOWN IMPORTED)
    set_target_properties(NDDS_CORE::NDDS_CORE PROPERTIES
	INTERFACE_COMPILE_DEFINITIONS "-m64 -DRTI_UNIX -DRTI_LINUX -DRTI_64BIT"
	INTERFACE_LINK_LIBRARIES "-ldl -lnsl -lm -lpthread -lrt"
        IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
	INTERFACE_INCLUDE_DIRECTORIES "${CONNEXTDDS_INCLUDE_DIRS}"
	INTERFACE_SYSTEM_INCLUDE_DIRECTORIES  "${GTEST_INCLUDE_DIRS}"
	IMPORTED_LOCATION "${NDDS_CORE_LIBRARY}"
   )

else(NOT TARGET NDDS_CORE::NDDS_CORE)

endif(NOT TARGET NDDS_CORE::NDDS_CORE)


if(NOT TARGET NDDS_CPP::NDDS_CPP)
    add_library(NDDS_CPP::NDDS_CPP UNKNOWN IMPORTED)
    set_target_properties( NDDS_CPP::NDDS_CPP PROPERTIES
        INTERFACE_LINK_LIBRARIES "-ldl -lnsl -lm -lpthread -lrt"
        IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
	INTERFACE_INCLUDE_DIRECTORIES "${CONNEXTDDS_INCLUDE_DIRS}"
        IMPORTED_LOCATION "${NDDS_CPP_LIBRARY}"
   )

else(NOT TARGET NDDS_CPP::NDDS_CPP)


endif(NOT TARGET NDDS_CPP::NDDS_CPP)



