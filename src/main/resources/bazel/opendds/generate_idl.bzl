

TAO_IDL_BIN = select({
    "//conditions:default": "/opt/dds/opendds/bin/tao_idl",
})

OPENDDS_IDL_BIN = select({
    "//conditions:default": "/opt/dds/opendds/bin/opendds_idl",
})

TAO_IDL_OPTS = select({
    "//conditions:default": [
        "-Wb,pre_include=ace/pre.h",
        "-Wb,post_include=ace/post.h",
        "--unknown-annotations ignore",
        "-I$TAO_ROOT",
        "-I$DDS_ROOT",
        "-I$ACE_ROOT",
        "-in",
        "-Gstl",
        "-hc Client.hpp",
        "-ss Server.cpp",
        "-hs Server.hpp",
        "-cs Client.cpp",
        "-hT ServerTemplateSkeleton.hpp",
        "-sT ServerTemplateSkeleton.cpp",
        "--idl-version 4",
        "-Sa",
        "-St",
    ],
})

OPENDDS_IDL_OPTS = select({
    "//conditions:default": [
        "-Sa",
        "-St",
        "-Lc++11",
        "-Lspcpp",
        "-Cw",
        "--idl-version 4",
        "-v", 
        "--unknown-annotations ignore",
    ],
})

# https://docs.bazel.build/versions/master/skylark/rules.html#actions
# https://docs.bazel.build/versions/master/skylark/lib/actions.html

def _tao_idl_impl(ctx):
    """General implementation for generating tao idl"""
    uic = ctx.executable._taoidl
    # idls = [idl for tgt in ctx.attr.idls for idl in tgt.files.to_list()]
    # outs = []
    # for input in ctx.files.idls:
        # print("input path {} ({})".format(input.basename,input.path))
        # print("workspace_root {} ".format(ctx.label.workspace_root))

def _tao_typesupport_idl(ctx):
    """General implementation for generating tao idl"""
    uic = ctx.executable._taoidl

def _opendds_idl(ctx):
    """General implementation for generating opendds idl"""
    uic = ctx.executable._openddsidl

def _tao_idl_gen_impl(ctx):
    """General implementation for generating tao idl"""
    _tao_idl_impl(ctx)
    _opendds_idl(ctx)
    _tao_typesupport_idl(ctx)

tao_idl_gen = rule(
    implementation = _tao_idl_gen_impl,
    attrs = {
        "idls": attr.label_list(
             allow_files = [".idl"],
             doc = "The .IDL files to generate to c++."
        ),
        "_taoidl": attr.label(
            # default = Label("@opendds//:bin/tao_idl"),
            executable = True,
            cfg = "host",
            allow_single_file = True,
        ),
        "_openddsidl": attr.label(
            # default = Label("@opendds//:bin/opendds_id"),
            executable = True,
            cfg = "host",
            allow_single_file = True,
        ),
    },
    # outputs = {
        # "clthdr": "%{name}Client.hpp",
        # "clthdr": "{}Client.hpp".format(basename)),
        # "cltsrc": "{}Client.cpp".format(basename)),
        # "srvhdr": "{}Server.hpp".format(basename)),
        # "srvsrc": "{}Server.cpp".format(basename)),
        # "skelhdr": "{}ServerTemplateSkeleton.hpp".format(basename)),
        # "skelsrc": "{}ServerTemplateSkeleton.cpp".format(basename)),
     # },
    output_to_genfiles = True,
)
