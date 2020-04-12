TAO_IDL_BIN = select({
#    "//conditions:default": "/usr/local/bin/tao_idl",
    "//conditions:default": "@ace_tao_opendds_binaries//:tao-idl-bin",
})

OPENDDS_IDL_BIN = select({
    "//conditions:default": "@ace_tao_opendds_binaries//:opendds-idl-bin",
})

JAVA_IDL_BIN = select({
    "//conditions:default": "@ace_tao_opendds_binaries//:idl-2-jni",
})

ACE_PERF_BIN = select({
    "//conditions:default": "@ace_tao_opendds_binaries//:ace-perf",
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

def opendds_idl_gen(name, src, **kwargs):
    native.genrule(
        name = name,
        srcs = [src],
        outs = ["small_" + src],
        cmd = "opendds_idl -Sa -St $@ -o $(GEN_DIR)",
    )

def TypeSupport_idl_gen(name, src, **kwargs):
    native.genrule(
        name = name,
        srcs = [src],
        outs = ["small_" + src],
        cmd = "tao_idl -Wb,pre_include=$(ACE_ROOT)/ace/pre.h -Wb,post_include=$(ACE_ROOT)/ace/post.h -I$(TAO_ROOT) -Sa -St -I$(DDS_ROOT) $(GEN_DIR)/*TypeSupport.idl -o $(GEN_DIR) $(TAO_INCLUDES)",
    )

def omg_dds_repository():
    return native.new_local_repository(
        name = "open_dds_repo",
        build_file = "@//:BUILD.ace_tao_opendds",
        path = "/usr/include",
    )

def eprosima_dds_repository():
    return native.new_local_repository(
        name = "fast_dds_repo",
        build_file_content = "\n".join([
            "exports_files(glob(['cdr/**']), ",
            "              visibility = ['//visibility:public'])",
        ]),
        path = "/usr/include",
    )

def rti_connext_dds_repository():
    return native.new_local_repository(
        name = "rti_dds_repo",
        build_file_content = "\n".join([
            "exports_files(glob(['ndds/**']), ",
            "              visibility = ['//visibility:public'])",
        ]),
        path = "/usr/include",
    )

def vortex_dds_repository():
    return native.new_local_repository(
        name = "ospl_dds_repo",
        build_file_content = "\n".join([
            "exports_files(glob(['ospl/**']), ",
            "              visibility = ['//visibility:public'])",
        ]),
        path = "/usr/include",
    )


# omg_dds_repository()
# eprosima_dds_repository()
# rti_dds_repository()

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


def proto_library(name, src=None, deps=[], visibility=None,
                  gen_java=False, gen_cc=False, gen_py=False):
    if gen_java:
        java_deps = ["@ace_tao_opendds_binaries//:idl-2-jni"]

    if gen_cc:
        cc_deps = [
            "@ace_tao_opendds_binaries//:tao-idl-bin",
            "@ace_tao_opendds_binaries//:opendds-idl-bin",
            "@ace_tao_opendds_binaries//:ace-perf",
        ]

    if gen_py:
        py_deps = ["@ace_tao_opendds_binaries//:itl2py"]

idl_gen = rule(
    implementation = _tao_idl_gen_impl,
    attrs = {
        "idls": attr.label_list(
            allow_files = [".idl"],
            doc = "The .IDL files to generate to c++.",
        ),
        "_taoidl": attr.label(
            # default = Label("@opendds//:bin/tao_idl"),
            executable = True,
            cfg = "host",
            allow_single_file = True,
        ),
        "_openddsidl": attr.label(
            # default = Label("@opendds//:bin/opendds_id"),
            # default = Label("@ace_tao_opendds_binaries//:opendds-idl-bin"),
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
