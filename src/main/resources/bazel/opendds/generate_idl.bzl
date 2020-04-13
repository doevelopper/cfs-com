
# https://docs.bazel.build/versions/master/skylark/rules.html#actions
# https://docs.bazel.build/versions/master/skylark/lib/actions.html


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

IDL_GENERIC_OPTS = select({
    "//conditions:default": [
        "--unknown-annotations ignore",
        "--idl-version 4",
        "-Sa",
        "-St",
    ],
})

TAO_IDL_OPTS = select({
    "//conditions:default": [
        "-Wb,pre_include=ace/pre.h",
        "-Wb,post_include=ace/post.h",
        "-I$$TAO_ROOT",
        "-I$$DDS_ROOT",
        "-I$$ACE_ROOT",
        "-in",
        "-Gstl",
        "-hc Client.hpp",
        "-ss Server.cpp",
        "-hs Server.hpp",
        "-cs Client.cpp",
        "-hT ServerTemplateSkeleton.hpp",
        "-sT ServerTemplateSkeleton.cpp",
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

IDL_OPTS = select({
    "//conditions:default": [
        "-Wb,pre_include=ace/pre.h",
        "-Wb,post_include=ace/post.h",
        "--unknown-annotations ignore",
        "-I$$TAO_ROOT",
        "-I$$DDS_ROOT",
        "-I$$ACE_ROOT",
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

def _GetPath(ctx, path):
    if ctx.label.workspace_root:
        return ctx.label.workspace_root + "/" + path
    else:
        return path

def _IsNewExternal(ctx):
    # Bazel 0.4.4 and older have genfiles paths that look like:
    #   bazel-out/local-fastbuild/genfiles/external/repo/foo
    # After the exec root rearrangement, they look like:
    #   ../repo/bazel-out/local-fastbuild/genfiles/foo
    return ctx.label.workspace_root.startswith("../")

def _GenDir(ctx):
    if _IsNewExternal(ctx):
        # We are using the fact that Bazel 0.4.4+ provides repository-relative paths
        # for ctx.genfiles_dir.
        return ctx.genfiles_dir.path + ( "/" + ctx.attr.idls[0] if ctx.attr.idls and ctx.attr.idls[0] else "")

    # This means that we're either in the old version OR the new version in the local repo.
    # Either way, appending the source path to the genfiles dir works.
    return ctx.var["GENDIR"] + "/" + _SourceDir(ctx)

def _SourceDir(ctx):
    if not ctx.attr.idls:
        return ctx.label.workspace_root
    if not ctx.attr.idls[0]:
        return _GetPath(ctx, ctx.label.package)
    if not ctx.label.package:
        return _GetPath(ctx, ctx.attr.idls[0])
    return _GetPath(ctx, ctx.label.package + "/" + ctx.attr.idls[0])

def idl_library( name, idls, **kwargs):
    if len(idls) > 1:
        fail("Only one srcs value supported", "srcs")
    extra_deps = []
    idl_targets = []
    idl_target = "_" + name + "_only"
    cc_idl_target = "_" + name + "_cc_idl"

    codegen_idl_target = "_" + name + "_idl_codegen"
    generate_idl2cpp(
        name = codegen_idl_target,
        idls = idls,
        **kwargs
    )

    native.cc_library(
        name = name,
        srcs = [":" + codegen_idl_target],
        hdrs = [":" + codegen_idl_target],
        **kwargs
    )

def _generate_idl2cpp(ctx):
    files = []
    # print("_GetPath {} ".format(_GetPath))
    # print("_IsNewExternal {} ".format(_IsNewExternal))
    # print("_GenDir {} ".format(_GenDir))
    # source_dir = _SourceDir(ctx)
    # gen_dir = _GenDir(ctx).rstrip("/")

    # if source_dir:
        # import_flags = ["-I" + source_dir, "-I" + gen_dir]
    # else:
        # import_flags = ["-I."]
    # print("ctx.attr.idls[0] {} ".format(ctx.attr.idls[0]))
    # print("ctx.label.package {} ".format(ctx.label.package))

    for idl_file in ctx.files.idls:
        # print("ctx.bin_dir {} ".format(ctx.bin_dir))
        # print("ctx.build_file_path {} ".format(ctx.build_file_path))
        # print("idl: {} ".format(idl_file.path))
        # print("idl short_path: {} ".format(idl_file.short_path))
        # print("ctx.genfiles_dir.path: {} ".format(ctx.genfiles_dir.path))
        # print("idl basename: {} ".format(idl_file.basename))
        # file_name = idl_file.path[0:-len(idl_file.extension) - 1]
        file_name = idl_file.path[0:-len(idl_file.extension) - 1]
        print("File name: {} ".format(file_name))
        # output_path = clthdr.path[0:-len(file_name) - 5]
        output_path = idl_file.dirname
        print("output path: {} ".format(output_path))

        hdrinl = ctx.actions.declare_file("{}C.inl".format(file_name))
        print("hdrinl: {} ".format(hdrinl))

        clthdr = ctx.actions.declare_file("{}Client.hpp".format(file_name))
        # print("clthdr: {} ".format(clthdr))

        cltsrc = ctx.actions.declare_file("{}Client.cpp".format(file_name))
        # print("cltsrc: {} ".format(cltsrc))

        srvhdr = ctx.actions.declare_file("{}Server.hpp".format(file_name))
        # print("srvhdr: {} ".format(srvhdr))

        srvsrc = ctx.actions.declare_file("{}Server.cpp".format(file_name))
        # print("srvsrc: {} ".format(srvsrc))

        files.append(hdrinl)
        files.append(clthdr)
        files.append(cltsrc)
        files.append(srvhdr)
        files.append(srvsrc)
        # print("location output path: {} ".format(output_path))
        command = "tao_idl --idl-version 4 --unknown-annotations ignore  -in -Sa -St"
        command += " "
        command += "-ae -GC "
        command += " "
        command += "-Wb,pre_include=ace/pre.h -Wb,post_include=ace/post.h"
        command += " "
        # command += " -I$TAO_ROOT -I$DDS_ROOT -I$ACE_ROOT "
        command += " -ci Client.inl -hc Client.hpp -cs Client.cpp -hs Server.hpp -ss Server.cpp  -hT ServerTemplateSkeleton.hpp -sT ServerTemplateSkeleton.cpp "
        command += " "
        command += " {} -o {} ".format(idl_file.path,output_path)

        ctx.actions.run_shell(
            outputs = [
                hdrinl, 
                clthdr, 
                cltsrc, 
                srvhdr,
                srvsrc
            ],
            inputs = [idl_file],
            command = command,
            progress_message = "Processing file {} ".format(idl_file),
            use_default_shell_env = True,
        )
        # print("output_path: {} ".format(output_path))
        return [DefaultInfo(files=depset(files))]

generate_idl2cpp = rule(
    attrs = {
        "idls": attr.label_list(
            allow_files = [".idl"],
            doc = "The .IDL files to generate to c++.",
        ),
        "gen_opendds_idl2cpp": attr.bool(),
        "gen_fatsrtps_idl2cpp": attr.bool(),
        "gen_connex_dds_idl2cpp": attr.bool(),
        "gen_vortex_dds_idl2cpp": attr.bool(),
    },
	output_to_genfiles = True,
    implementation = _generate_idl2cpp,
)
