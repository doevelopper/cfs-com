#       CMakeLists.txt
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

project (cfs-com CXX)

cmake_minimum_required(VERSION 3.11 FATAL_ERROR)

set(${PROJECT_NAME}_MAJOR_VERSION       "1")
set(${PROJECT_NAME}_MINOR_VERSION       "0")
set(${PROJECT_NAME}_MICRO_VERSION       "0")
set(${PROJECT_NAME}_PATCH_VERSION       "-")
set(${PROJECT_NAME}_PATCH_LEVEL         "0")
set(${PROJECT_NAME}_REVISION_VERSION    "0")
set(${PROJECT_NAME}_VERSION "${${PROJECT_NAME}_MAJOR_VERSION}.${${PROJECT_NAME}_MINOR_VERSION}.${${PROJECT_NAME}_PATCH_LEVEL}" )
set("BUILD_SHARED_LIBS" OFF CACHE INTERNAL "If enabled, shared libs will be built by default, otherwise static libs")

add_definitions(-DRELEASE_LEVEL="SNAPSHOOT") # SNAPSHOOT ,ALPHA , BETA , CANDIDATE , FINAL.

if(NOT COMMON_MODULE_TOOLS)

    list(APPEND CMAKE_MODULE_PATH
        "${CMAKE_SOURCE_DIR}/src/main/resources/cmake"
        "${CMAKE_SOURCE_DIR}/src/main/resources/cmake/modules"
        "${CMAKE_SOURCE_DIR}/src/main/resources/cmake/toolChains"
        "${CMAKE_SOURCE_DIR}/src/main/resources/cmake/macros"
        "${CMAKE_SOURCE_DIR}/src/test/resources/cmake"
    )
    #set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/src/main/resources/cmakeModule" CACHE STRING "Modules for CMake" FORCE)

  if (NOT TARGET  LOG4CXX::LOG4CXX)
      find_package(Log4cxx REQUIRED)
  endif(NOT TARGET  LOG4CXX::LOG4CXX)

  if (NOT TARGET GTest::GTest AND NOT TARGET GMock::GMock)
      find_package(GoogleTestFwk REQUIRED)
  endif(NOT TARGET GTest::GTest AND NOT TARGET GMock::GMock)

  if (NOT TARGET CUCUMBER-CPP::CUCUMBER-CPP)
	  find_package(Cucumber-cpp)
  endif(NOT TARGET CUCUMBER-CPP::CUCUMBER-CPP)
  
else(NOT COMMON_MODULE_TOOLS)
   massage(STATUS "${PROJECT_NAME} will use modules path defined in main parent dir")
endif(NOT COMMON_MODULE_TOOLS)

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

