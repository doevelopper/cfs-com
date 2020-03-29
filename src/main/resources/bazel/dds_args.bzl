DEFAULT_INCLUDE_PATHS = [
    "./",
    "$(GENDIR)",
    "$(BINDIR)",
]

COMMON_IDL_FLAG = [
    "--idl-version 4",
    "-Sa",
    "-St",

]
DEFAULT_TAO_IDL_ARGS = COMMON_IDL_FLAG  + select({
    "//conditions:default":[
        "-Wb,pre_include=ace/pre.h",
        "-Wb,post_include=ace/post.h",
        "-I$TAO_ROOT",
        "-I$DDS_ROOT",
        "-in",
        "-hc Client.hpp",
        "-hs Server.hpp",
        "-hT ServerTemplateSkeleton.hpp",
        "-cs Client.cpp",
        "-ss Server.cpp",
        "-sT ServerTemplateSkeleton.cpp",
    ],
})

DEFAULT_OPENDDS_IDL_ARGS = COMMON_IDL_FLAG  + select({
    "//conditions:default":[
        "-Lc++11",
    ],
})

