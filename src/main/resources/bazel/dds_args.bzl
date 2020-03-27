DEFAULT_INCLUDE_PATHS = [
    "./",
    "$(GENDIR)",
    "$(BINDIR)",
]

DEFAULT_TAO_IDL_ARGS = [
    "-Wb,pre_include=ace/pre.h",
    "-Wb,post_include=ace/post.h",
    "-I$TAO_ROOT",
    "-Sa",
    "-St",
    "-I$DDS_ROOT",
    "--idl-version 4",
    "-in",
    "-hc Client.hpp",
    "-hs Server.hpp",
    "-hT ServerTemplateSkeleton.hpp",
    "-cs Client.cpp",
    "-ss Server.cpp",
    "-sT ServerTemplateSkeleton.cpp",
]

DEFAULT_OPENDDS_IDL_ARGS = [
    "--idl-version 4",
    "-Lc++11",
    "-Sa",
    "-St",
]
