

add_executable(cfs.com.it-test.steps
    features/step_definitions/cfs/com/Steps
    features/step_definitions/cfs/com/ErrorSteps
    features/step_definitions/cfs/com/DdsSteps
)
target_link_libraries(cfs.com.it-test.steps
    PUBLIC  
        cfs.com.main
#        cfs.com.test
        CUCUMBER-CPP::CUCUMBER-CPP
##         PUBLIC BENCHMARK::BENCHMARK
)

add_custom_target(cfs.com.integration-test
#    COMMAND cfs.com.it-test.steps --port 3902  >/dev/null &
    COMMAND cucumber --format progress --backtrace --format html --color --out ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cfs.com.cucumber-report.html --strict ${CMAKE_CURRENT_SOURCE_DIR}/features/cfs/com
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    DEPENDS cfs.com.it-test.steps
    COMMENT "Running cfs.com  integration test"
)

add_custom_command(TARGET cfs.com.integration-test
    PRE_BUILD
    COMMAND
        cfs.com.it-test.steps --port 3902  >/dev/null &
    WORKING_DIRECTORY
        ${CMAKE_CURRENT_SOURCE_DIR}
    WORKING_DIRECTORY
        ${CMAKE_CURRENT_SOURCE_DIR}
    COMMENT
        "Start cucumber's wire server on port 3902."
)


add_custom_command(TARGET cfs.com.integration-test 
    POST_BUILD
    COMMAND
        fuser -k -n  tcp 3902 # kill -9 l101.it-test.steps which is using port 3902
        # iptables -I INPUT -p tcp --dport 3902 -j DROP ;# need to be root for this command
    COMMENT
        // check pro opened lsof -i -P -n | grep LISTEN 
        "Killing process to close cucumber wire port. (bind: Address already in use)"
)

