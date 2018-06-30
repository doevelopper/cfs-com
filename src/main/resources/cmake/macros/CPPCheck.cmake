


# cppcheck --enable=all --inconclusive --xml-version=2 --force --library=windows,posix,gnu <PATH_TO_SOURCE> 2> result.xml &&\
# cppcheck-htmlreport --source-encoding="iso8859-1" --title="my project name" --source-dir=<PATH_TO_SOURCE> \
# --report-dir=<OUTPUT_DIR> --file=result.xml && rm result.xml 

set(CPPCHECK_HTMLREPORT_GENERATOR "${PROJECT_SOURCE_DIR}/src/main/scripts/cppcheck-htmlreport.py")
set(CONTROVERSIAL "–inconclusive")
set(CPPCHECK_TEMPLATE_ARG --template gcc) # --template="[{severity}][{id}] {message} {callstack} \(On {file}:{line}\)" 

set(CPPCHECK_OPTIONS
    ${CONTROVERSIAL}
    --report-progress
#    --platform=native
    --platform=unix64
    --enable=warning,performance,portability,information,missingInclude,style
#    --project=/home/happyman/Documents/levitics-arkhe-cfs/build/Debug/compile_commands.json
    --enable=all
    --std=c++14
    --std=c11
    --std=posix
    --inline-suppr
#    --language= c++
#    --suppress=missingIncludeSystem
#    --library=qt.cfg 
    --verbose 
#    --quiet
    --xml-version=2
    -j4
#    -j${Ncpu}
#    --error-exitcode=25000
#    -I${INC_DIR}
)

find_package(PythonInterp QUIET)

if(PYTHONINTERP_FOUND)
else(PYTHONINTERP_FOUND)
    message(STATUS "Python executable not found. Skipped Cppchec HTML Generator")
endif(PYTHONINTERP_FOUND)

find_program(CPPCHECK cppcheck
    NAMES cppcheck
    PATHS  /home/happyman/gcs_installs/cppehck_install/bin #/usr/local/bin /opt/cmake/bin
#   NO_DEFAULT_PATH
)

if(CPPCHECK)
    #message(STATUS "${CPPCHECK} : found")
    execute_process(
         COMMAND ${CPPCHECK} --version OUTPUT_VARIABLE CPPCHECK_VERSION
         OUTPUT_STRIP_TRAILING_WHITESPACE)
         string(REGEX REPLACE ".+([0-9]+\\.[0-9]+)" "\\1" CPPCHECK_VERSION ${CPPCHECK_VERSION}
    )
    #message(STATUS "${CPPCHECK} : ${CPPCHECK_VERSION}")
    mark_as_advanced(CPPCHECK CPPCHECK_VERSION)
    set(RUN_CPPCHECK ON)
endif(CPPCHECK)


function(ADD_CPPCHECK_ANALYSIS target_name bin_folder)

    if(RUN_CPPCHECK)

        set(WORKING_DIR "${CMAKE_BINARY_DIR}/qa/cppcheck/${target_name}")
        file(MAKE_DIRECTORY ${WORKING_DIR})

        file(GLOB_RECURSE ALL_SOURCE_FILES ${bin_folder} *.cpp) 
        file(GLOB_RECURSE ALL_HEADER_FILES ${bin_folder} *.hpp)

        add_custom_target( ${target_name}-cppcheck
#            COMMAND ${CPPCHECK}  ${CPPCHECK_OPTIONS} ${CPPCHECK_TEMPLATE_ARG} ${ALL_SOURCE_FILES} ${ALL_HEADER_FILES} 
            COMMAND cppcheck  ${CPPCHECK_OPTIONS} ${CPPCHECK_TEMPLATE_ARG} ${ALL_SOURCE_FILES} ${ALL_HEADER_FILES}  --cppcheck-build-dir=${WORKING_DIR} 2> ${WORKING_DIR}/cppcheck.xml
            COMMAND ${PYTHON_EXECUTABLE} ${CPPCHECK_HTMLREPORT_GENERATOR} --title=${target_name} --file=${WORKING_DIR}/cppcheck.xml  --source-dir=${bin_folder} --report-dir=${WORKING_DIR}
            WORKING_DIRECTORY ${bin_folder}
            DEPENDS ${ALL_SOURCE_FILES} ${ALL_HEADER_FILES}
            COMMENT "[CPPCHECK-Target] ${bin_folder}"
        )

    else(RUN_CPPCHECK)
        add_custom_target(
            ${target_name}-cppcheck 
            COMMAND ${CMAKE_COMMAND} -E echo "No Static Code analysis done"
        )
    endif(RUN_CPPCHECK)

    add_dependencies( validate ${target_name}-cppcheck)

endfunction(ADD_CPPCHECK_ANALYSIS)
