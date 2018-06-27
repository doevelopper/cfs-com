
if($ENV{FASTRTPSHOME})
    set(FastRTPS_HOME $ENV{FASTRTPSHOME})
endif()

find_path(FastRTPS_INCLUDE_DIR
	NAMES 
	    fastrtps/fastrtps_all.h 
	HINTS
	    $ENV{FASTRTPS_HOME}/include
)
