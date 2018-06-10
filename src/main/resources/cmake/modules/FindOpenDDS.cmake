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

find_path(OpenDDS_INCLUDE_DIR dds/DdsDcpsS.h
    HINTS
        $ENV{HOME}/gcs_installs/dds/opendds 
        ${DDS_ROOT}/include 
	$ENV{DDS_ROOT}/include
        $ENV{NDDSHOME}/include
    DOC "OpenDDs header"
)

find_program(OPENDDS_IDL opendds_idl
    HINTS
        $ENV{HOME}/gcs_installs/dds/opendds
	DOC "Opend DDS IDL executable."
)

find_program(TAO_PENDDS_IDL tao_idl
    HINTS
        $ENV{HOME}/gcs_installs/dds/opendds
	DOC "TAO DDS IDL executable."
)

find_library(OPENDDS_DCPS_LIBRARY
    NAMES 
        libOpenDDS_Dcps OpenDDS_Dcps
    HINTS
        $ENV{HOME}/gcs_installs/dds/opendds
)

mark_as_advanced(OPENDDS_IDL TAO_PENDDS_IDL)



include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(OPENDDS_LIBS DEFAULT_MSG APU_INCLUDES OPENDDS_DCPS_LIBRARY)

