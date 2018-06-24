
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

macro( opensplice_file_generated idl_file)

    set(file_generated_from_idl )

    GET_FILENAME_COMPONENT(full_path_to_file ${idl_file} ABSOLUTE)
    GET_FILENAME_COMPONENT(base_file_name ${idl_file} NAME_WE)

    set(file_generated_from_idl ${file_generated_from_idl} gen/${base_file_name}.cpp gen/${base_file_name}.h)
    set(file_generated_from_idl ${file_generated_from_idl} gen/${base_file_name}Dcps.cpp gen/${base_file_name}Dcps.h)
    set(file_generated_from_idl ${file_generated_from_idl} gen/${base_file_name}Dcps_impl.cpp gen/${base_file_name}Dcps_impl.h)
    set(file_generated_from_idl ${file_generated_from_idl} gen/${base_file_name}SplDcps.cpp gen/${base_file_name}SplDcps.h)
    set(file_generated_from_idl ${file_generated_from_idl} gen/ccpp_${base_file_name}.h)

endmacro(opensplice_file_generated idl_file)

MACRO (OpenSplice_IDLGEN idlfilename)

    GET_FILENAME_COMPONENT(it ${idlfilename} ABSOLUTE)
    GET_FILENAME_COMPONENT(idlfilename ${idlfilename} NAME)
    
    opensplice_file_generated (${ARGV})

    ADD_CUSTOM_COMMAND (
        OUTPUT ${file_generated_from_idl}
        COMMAND ${VORTEXDDS_IDL_COMPILER}
        ARGS  -S -l isoc++2 -I $ENV{OSPL_HOME}/etc/idl  -d gen ${idlfilename}
        DEPENDS ${it}
    )

ENDMACRO (OpenSplice_IDLGEN)


set(ENV{OSPL_HOME} "/home/happyman/Documents/vortexopenplice")
set(ENV{SPLICE_TARGET} "x86_64.linux-release")

FIND_PATH(OpenSplice_INCLUDE_DIR
    NAMES
        ccpp_dds_dcps.h
    HINTS
        $ENV{OSPL_HOME}/install/HDE/$ENV{SPLICE_TARGET}/include/dcps/C++/SACPP
)

set(OpenSplice_INCLUDE_DIRS
    ${OpenSplice_INCLUDE_DIR}
    $ENV{OSPL_HOME}/install/HDE/$ENV{SPLICE_TARGET}/include
    $ENV{OSPL_HOME}/install/HDE/$ENV{SPLICE_TARGET}/include/sys
    $ENV{OSPL_HOME}/etc/idl
)

set (idl_compiler_exe 
)

FIND_LIBRARY(DCPSGAPI_LIBRARY
    NAMES
        dcpsgapi
    PATHS
        $ENV{OSPL_HOME}/lib/$ENV{SPLICE_TARGET}
)

FIND_LIBRARY(DCPSSACPP_LIBRARY
    NAMES
        dcpssacpp
    PATHS
        $ENV{OSPL_HOME}/lib/$ENV{SPLICE_TARGET}
)

FIND_LIBRARY(DDSDATABASE_LIBRARY
    NAMES
        ddsdatabase
    PATHS
        $ENV{OSPL_HOME}/lib/$ENV{SPLICE_TARGET}
)

FIND_LIBRARY(DDSOS_LIBRARY
    NAMES
        ddsos
    PATHS
        $ENV{OSPL_HOME}/lib/$ENV{SPLICE_TARGET}
)

set(OpenSplice_LIBRARIES
    ${DCPSGAPI_LIBRARY}
    ${DCPSSACPP_LIBRARY}
    ${DDSDATABASE_LIBRARY}
    ${DDSOS_LIBRARY}
)

find_program(VORTEXDDS_IDL_COMPILER 
    NAMES 
        idlpp
    HINTS 
        $ENV{OSPL_HOME}/exec/$ENV{SPLICE_TARGET}
    DOC 
        "OpenDDS IDL Compiler"
)

#set (idl_compiler $ENV{OSPL_HOME}/exec/$ENV{SPLICE_TARGET}/idlpp -I $ENV{OSPL_HOME}/etc/idl)


