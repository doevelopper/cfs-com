#       cfs-com/CMakeLists.txt
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
#        WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

cmake_minimum_required(VERSION 3.11 FATAL_ERROR)

project (cfs-com
#<major>.<minor>.<micro>.<patch>[.<tweak>][-rc<n>][-<date>][-<id>]
    VERSION 0.0.0.0
    DESCRIPTION "VxWorks Cmake DEMO!"
    HOMEPAGE_URL "https://exemple.com"
    LANGUAGES CXX
)

set("BUILD_SHARED_LIBS" OFF CACHE INTERNAL "If enabled, shared libs will be built by default, otherwise static libs")

add_definitions(-DRELEASE_LEVEL="SNAPSHOOT") # SNAPSHOOT ,ALPHA , BETA , CANDIDATE , FINAL.


list(APPEND CMAKE_MODULE_PATH
    "${CMAKE_SOURCE_DIR}/src/main/resources/cmake"
    "${CMAKE_SOURCE_DIR}/src/main/resources/cmake/modules"
    "${CMAKE_SOURCE_DIR}/src/main/resources/cmake/toolChains"
    "${CMAKE_SOURCE_DIR}/src/main/resources/cmake/macros"
    "${CMAKE_SOURCE_DIR}/src/test/resources/cmake"
    "${CMAKE_SOURCE_DIR}/src/test/resources/scripts"
)
#set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/src/main/resources/cmakeModule" CACHE STRING "Modules for CMake" FORCE)

include(TestBigEndian)
TEST_BIG_ENDIAN(IS_BIG_ENDIAN)

if(IS_BIG_ENDIAN)
     message(FATAL_ERROR "Big endian isn't supported !!!")
endif(IS_BIG_ENDIAN)

include(ProcessorCount)
ProcessorCount(N)

include(CompilerOption)

include(DefinePlatformSpecfic)

get_property(cxx_known_features GLOBAL PROPERTY CMAKE_CXX_KNOWN_FEATURES)
get_property(c_known_features GLOBAL PROPERTY CMAKE_C_KNOWN_FEATURES)

include(WriteCompilerDetectionHeader)
write_compiler_detection_header(
    FILE ${CMAKE_CURRENT_BINARY_DIR}/cfs/com/CompilerDetection.hpp
    PREFIX CFS_COM
#   OUTPUT_FILES_VAR <output_files_var> OUTPUT_DIR <output_dir>
    COMPILERS GNU
    FEATURES ${cxx_known_features}
    VERSION "${CMAKE_VERSION}"
    PROLOG "//<prolog>"
    EPILOG "//<epilog>"
#   ALLOW_UNKNOWN_COMPILERS
#   ALLOW_UNKNOWN_COMPILER_VERSIONS
)


configure_file("${PROJECT_SOURCE_DIR}/src/main/resources/cmake/Config.hpp.in"
	       "${CMAKE_CURRENT_BINARY_DIR}/cfs/com/Config.hpp"
               @ONLY)

configure_file("${PROJECT_SOURCE_DIR}/src/main/resources/cmake/GitRevision.hpp.in"
               "${CMAKE_CURRENT_BINARY_DIR}/cfs/com/GitRevision.hpp"
               @ONLY)


if (NOT TARGET XercesC::XercesC)
    find_package(XercesC REQUIRED)
endif(NOT TARGET XercesC::XercesC)

find_package(Doxygen
   REQUIRED
       dot
   OPTIONAL_COMPONENTS
       mscgen dia
)

find_package( OpenDDS REQUIRED)
find_package( OpenSpliceVortexDDS REQUIRED)
#find_package( GoogleTestFwk)
#find_package(RTIConnexDDS REQUIRED)
include(GoogleTest) #gtest_discover_tests
include(CTest)
include(goals)
include(CPPCheck)
include(CodingStyle)

apply_style_targets(
    ${PROJECT_NAME}-hal
    ${CMAKE_CURRENT_BINARY_DIR}
)

add_subdirectory (src/main/cpp)
add_subdirectory (src/test/cpp)
add_subdirectory (src/it)

