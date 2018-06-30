

add_library(cfs.com.test
    cfs/com/unitTest
    cfs/com/Test
)

target_include_directories(cfs.com.test
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/cfs/com>
        $<INSTALL_INTERFACE:${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cfs/com>
)

target_link_libraries(cfs.com.test
    PUBLIC 
        GMock::GMock 
        GTest::GTest
        cfs.com.main
)

option(TEST_EXCLUDE_DEPRECATED "Exclude deprecated parts of the library" TRUE)
if (TEST_EXCLUDE_DEPRECATED)
    set(NO_BUILD_DEPRECATED DEFINE_NO_DEPRECATED)
endif()

include(GenerateExportHeader)
generate_export_header(cfs.com.main
    EXPORT_FILE_NAME "${CMAKE_CURRENT_BINARY_DIR}/cfs/com/TestExport.hpp"
    INCLUDE_GUARD_NAME TEST_CFS_COM_EXPORT_HPP
    # EXPORT_MACRO_NAME API_DECLS
    #BASE_NAME EDAC
    #PREFIX_NAME EDAC_
    #STATIC_DEFINE BUILT_AS_STATIC
    DEPRECATED_MACRO_NAME TEST_CFS_COM_DEPRECATED
    ${NO_BUILD_DEPRECATED}
)

add_executable(cfs.com.test.bin
    cfs/com/ErrorTest
)

target_link_libraries (cfs.com.test.bin
    PUBLIC
        cfs.com.test
)

gtest_discover_tests(cfs.com.test.bin
    WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
    TEST_PREFIX "CFS-COM:-: "
    TEST_SUFFIX ---- 
    PROPERTIES LABELS CFS::COM TEST
    DISCOVERY_TIMEOUT 10
    EXTRA_ARGS --iterration 1 --outputpath ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} --module cfs.com.test
)

#ADD_CPPCHECK_ANALYSIS( cfs.com.test ${CMAKE_CURRENT_SOURCE_DIR})



