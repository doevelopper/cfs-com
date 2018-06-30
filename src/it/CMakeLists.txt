

add_executable(cfs.com.it-test.steps
    cfs/com/features/step_definitions/Steps
    cfs/com/features/step_definitions/ErrorSteps
    cfs/com/features/step_definitions/DdsSteps
)
target_link_libraries(cfs.com.it-test.steps
    PUBLIC  
        cfs.com.main
#i      cfs.com.test
        CUCUMBER-CPP::CUCUMBER-CPP
        ##PUBLIC BENCHMARK::BENCHMARK
)

add_custom_target(cfs.com.integration-test
    COMMAND cfs.com.it-test.steps --port 3902  >/dev/null &
    COMMAND cucumber --format progress --backtrace --format html --color --out ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cfs.com.cucumber-report.html --strict ${CMAKE_CURRENT_SOURCE_DIR}/cfs/com/features
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    DEPENDS cfs.com.it-test.steps
    COMMENT "Start wire server and running cfs.com  integration test"
)
