

macro(COMPILE_OPENDDS_IDL idl_file idl_ption idl_ouput_directory)

    get_filename_component(idlfile ${idl_file} NAME_WE)

    add_custom_command(OUTPUT ${${idlfile}}
        COMMAND ${OPENDDS_IDL} -o ${idl_ouput_directory}
	COMMAND ${OPENDDS_IDL} -o ${idl_ouput_directory}
	COMMAND ${OPENDDS_IDL} -o ${idl_ouput_directory}
    )

endmacro(COMPILE_OPENDDS_IDL)
