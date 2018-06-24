#
#               Copyright (c) 2014-2018  A.H.L
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


add_library(cfs.com.main
    cfs/com/Error
    cfs/com/Exception
)

option(EXCLUDE_DEPRECATED "Exclude deprecated parts of the library" TRUE)
if (EXCLUDE_DEPRECATED)
    set(NO_BUILD_DEPRECATED DEFINE_NO_DEPRECATED)
endif()

include(GenerateExportHeader)
generate_export_header(cfs.com.main
    EXPORT_FILE_NAME "${CMAKE_CURRENT_BINARY_DIR}/cfs/com/Export.hpp"
    INCLUDE_GUARD_NAME CFS_COM_EXPORT_HPP
    # EXPORT_MACRO_NAME API_DECLS
    #BASE_NAME EDAC
    #PREFIX_NAME EDAC_
    #STATIC_DEFINE BUILT_AS_STATIC
    DEPRECATED_MACRO_NAME CFS_COM_DEPRECATED
    ${NO_BUILD_DEPRECATED}
)

target_compile_options(cfs.com.main
    PUBLIC
         $<$<CONFIG:Release>:-g0 -O2>
	 $<$<COMPILE_LANGUAGE:CXX>:-DNDEBUG -O3 -pipe -W -Wall -Wextra -Weffc++ -Wpedantic -fmax-errors=5 -Werror=shadow -fdiagnostics-parseable-fixits>
         $<$<CONFIG:Debug>: -O0 -g -D_DEBUG -D_FORTIFY_SOURCE=2 -fno-strict-aliasing -fno-omit-frame-pointer>
         $<$<CONFIG:Release>:-g0 -O2>
         $<$<CONFIG:Coverage>:-O0  -fprofile-arcs -ftest-coverage --coverage>
         $<$<CONFIG:Profile>:-fsanitize=memory -fsanitize-memory-track-origins=2 -fno-omit-frame-pointer>
)

set_target_properties(cfs.com.main PROPERTIES
    COMPILE_FLAGS "-I${CMAKE_BINARY_DIR}"
)

target_compile_features(cfs.com.main
    PUBLIC
        cxx_std_17
        cxx_strong_enums
        cxx_variadic_templates
        cxx_nullptr
        cxx_alias_templates
        cxx_auto_type
        cxx_constexpr
        cxx_defaulted_functions
        cxx_final
        cxx_lambdas
        cxx_noexcept
        cxx_nullptr
        cxx_rvalue_references
        cxx_thread_local
        cxx_variadic_templates
        cxx_override
    PRIVATE
        cxx_lambdas
        cxx_range_for
        $<$<CXX_COMPILER_ID:GNU>:cxx_attributes>
)


target_link_libraries(cfs.com.main
    PUBLIC
        LOG4CXX::LOG4CXX
)

add_executable(cfs.com.main.bin
    cfs/com/main.cpp
)

target_link_libraries(cfs.com.main.bin 
    cfs.com.main
)

target_include_directories(cfs.com.main
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/cfs/com>
        $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}>
	$<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>
	$<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/cfs/com/interface>
	$<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/cfs/com/internals>
	$<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/cfs/com/private>
	$<INSTALL_INTERFACE:$<INSTALL_PREFIX>/${CMAKE_INSTALL_INCLUDEDIR}>
        $<INSTALL_INTERFACE:${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cfs/com>
)


