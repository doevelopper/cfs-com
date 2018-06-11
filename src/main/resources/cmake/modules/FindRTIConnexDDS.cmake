
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

set(CONNEXTDDS_DEFINITIONS  
     "-DRTI_UNIX -DRTI_LINUX"
)

find_path(CONNEXTDDS_INCLUDE_DIRS
    NAMES ndds/ndds_c.h
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

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(RTI DEFAULT_MSG
  CONNEXTDDS_INCLUDE_DIRS CONNEXTDDS_LIBRARIES)


if(NOT TARGET NDDS_CORE::NDDS_CORE)
    add_library(NDDS_CORE::NDDS_CORE UNKNOWN IMPORTED)
    set_target_properties(NDDS_CORE::NDDS_CORE PROPERTIES
	INTERFACE_LINK_LIBRARIES "-ldl -lnsl -lm -lpthread -lrt"
        IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
	INTERFACE_INCLUDE_DIRECTORIES ${CONNEXTDDS_INCLUDE_DIRS}
	IMPORTED_LOCATION ${NDDS_CORE_LIBRARY}
   )

else(NOT TARGET NDDS_CORE::NDDS_CORE)

endif(NOT TARGET NDDS_CORE::NDDS_CORE)

if(NOT TARGET NDDS_CPP::NDDS_CPP)
    add_library(NDDS_CPP::NDDS_CPP UNKNOWN IMPORTED)
    set_target_properties( NDDS_CPP::NDDS_CPP PROPERTIES
        INTERFACE_LINK_LIBRARIES "-ldl -lnsl -lm -lpthread -lrt"
        IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
	INTERFACE_INCLUDE_DIRECTORIES ${CONNEXTDDS_INCLUDE_DIRS}
        IMPORTED_LOCATION ${NDDS_CPP_LIBRARY}
   )

else(NOT TARGET NDDS_CPP::NDDS_CPP)

endif(NOT TARGET NDDS_CPP::NDDS_CPP)



