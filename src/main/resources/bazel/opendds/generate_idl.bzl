
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

def _is_windows():
    return select({
        "@bazel_tools//src/conditions:windows": True,
        "//conditions:default": False,
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
        fail("Only one idls value supported", "idls")

    codegen_idl_target = "_" + name + "_idl_codegen"

    generate_idl2cpp(
        name = codegen_idl_target,
        idls = idls,
        **kwargs
    )

    native.cc_library(
        name = name,
        # srcs = [":" + codegen_idl_target],
        hdrs = [":" + codegen_idl_target],
        **kwargs
    )

def _use_tao_idl_4_generate_idl2cpp(ctx, from_typesupport_idl ):
    pass

def _use_opendds_idl_4_generate_idl2cpp(ctx):
    pass

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

    full_outdir = ctx.bin_dir.path + "/"
    if ctx.label.workspace_root:
        full_outdir += ctx.label.workspace_root + "/"
    if ctx.label.package:
        full_outdir += ctx.label.package + "/"
    # full_outdir += ctx.label.name

    for idl_file in ctx.files.idls:
        # print("ctx.bin_dir {} ".format(ctx.bin_dir))
        # print("ctx.build_file_path {} ".format(ctx.build_file_path))
        idl_file_path = idl_file.path.split("/idl/")[1].rpartition("/")[0]
        # print("idl file path: {} ".format(idl_file_path))
        # print("idl short_path: {} ".format(idl_file.short_path))
        # print("ctx.genfiles_dir.path: {} ".format(ctx.genfiles_dir.path))
        # print("idl basename: {} ".format(idl_file.basename))

        file_name = idl_file.path[0:-len(idl_file.extension) - 1]
        # print("File name: {} ".format(file_name))
        file_base_name = idl_file.basename[0:-len(idl_file.extension) - 1]
        # print("File: {} ".format(file_base_name))
        # output_path = clthdr.path[0:-len(file_name) - 5]
        output_path = idl_file.dirname
        # print("output path: {} ".format(output_path))
        full_outdir += idl_file_path
        hdrinl = ctx.actions.declare_file("{}/{}Client.inl".format(idl_file_path, file_base_name))
        # print("hdrinl: {} ".format(hdrinl))

        clthdr = ctx.actions.declare_file("{}/{}Client.hpp".format(idl_file_path, file_base_name))
        # print("clthdr: {} ".format(clthdr))

        cltsrc = ctx.actions.declare_file("{}/{}Client.cpp".format(idl_file_path, file_base_name))
        # print("cltsrc: {} ".format(cltsrc))

        srvhdr = ctx.actions.declare_file("{}/{}Server.hpp".format(idl_file_path, file_base_name))
        # print("srvhdr: {} ".format(srvhdr))

        srvsrc = ctx.actions.declare_file("{}/{}Server.cpp".format(idl_file_path, file_base_name))
        # print("srvsrc: {} ".format(srvsrc))
        # print("full_outdir: {} ".format(full_outdir))

        files.append(hdrinl)
        files.append(clthdr)
        files.append(cltsrc)
        files.append(srvhdr)
        files.append(srvsrc)
        # print("location output path: {} ".format(output_path))
        # command = ("mkdir -pv '{}' && ".format(full_outdir))
        # command = "uname && "
        command = "tao_idl --idl-version 4 --unknown-annotations ignore  -in -Sa -St"
        # command += "opendds_idl --idl-version 4 -v --unknown-annotations ignore -Sa -St -Lc++11 -Lspcpp -Cw  ".format(idl_file, full_outdir)
        command += " "
        command += "-ae -GC "
        command += " "
        command += "-Wb,pre_include=ace/pre.h -Wb,post_include=ace/post.h"
        ## command += " "
        ## command += " -I$TAO_ROOT -I$DDS_ROOT -I$ACE_ROOT "
        command += " "
        command += " -ci Client.inl -hc Client.hpp -cs Client.cpp -hs Server.hpp -ss Server.cpp  -hT ServerTemplateSkeleton.hpp -sT ServerTemplateSkeleton.cpp "
        command += " "
        command += " {} -o {} ".format(idl_file.path,full_outdir)

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
            progress_message = "TAO IDL: Generating srs  from {} in folder {}".format(idl_file,full_outdir),
            use_default_shell_env = True,
            env = {
                "ACE_ROOT" : "/usr/local/share/ace",
                "TAO_ROOT" : "/usr/local/share/tao",
                "DDS_ROOT" : "/usr/local/share/dds",
                "CIAO_ROOT" : "/usr/local/share/ciao",
                "DANCE_ROOT" : "/usr/local/share/dance",
                "LD_LIBRARY_PATH" :" $LD_LIBRARY_PATH:/usr/local/lib/:/opt/dds/opendds/lib",
                "CPATH" : "$CPATH:/opt/dds/opendds/include:/usr/local/include",
                "BOOST_ROOT" : "/usr/local",
                "GLIB_ROOT" : "/usr",
                "XERCESCROOT" : "/usr/local",
                "PROTOBUF_HOME" : "/usr/local",
                "SSL_ROOT" : "/usr/local",
            }
        )

        tschdr = ctx.actions.declare_file("{}/{}C.h".format(idl_file_path, file_base_name))
        tsidl = ctx.actions.declare_file("{}/{}TypeSupport.idl".format(idl_file_path, file_base_name))
        tshdr = ctx.actions.declare_file("{}/{}TypeSupportImpl.hpp".format(idl_file_path, file_base_name))
        tssrc = ctx.actions.declare_file("{}/{}TypeSupportImpl.cpp".format(idl_file_path, file_base_name))
        # files.append(tschdr)
        # files.append(tsidl)
        # files.append(tshdr)
        # files.append(tssrc)

        opendds_command = [" --help"]
        # opendds_command = ["-Sa", "-St", "--idl-version", "4", "-v", "--unknown-annotations", "ignore"]
        # opendds_command += [" "
        # opendds_command += [idl_file, "-o " + full_outdir]
        # opendds_command += ["{} -o {}".format(idl_file, full_outdir)

        ctx.actions.run(
            progress_message = "OpendDDS IDL Generating srs from {} \n in folder {}".format(idl_file,full_outdir), #"Packing " + ctx.label.package + ":" + ctx.label.name,
            outputs = [
                tschdr, 
                tsidl, 
                tshdr, 
                tssrc
            ],
            inputs = [idl_file],
            executable = "opendds_idl",
            arguments = opendds_command,
            use_default_shell_env = True,
            env = {
                "ACE_ROOT" : "/usr/local/share/ace",
                "TAO_ROOT" : "/usr/local/share/tao",
                "DDS_ROOT" : "/usr/local/share/dds",
                "CIAO_ROOT" : "/usr/local/share/ciao",
                "DANCE_ROOT" : "/usr/local/share/dance",
                "LD_LIBRARY_PATH" :" $LD_LIBRARY_PATH:/usr/local/lib/:/opt/dds/opendds/lib",
                "CPATH" : "$CPATH:/opt/dds/opendds/include:/usr/local/include",
                "BOOST_ROOT" : "/usr/local",
                "GLIB_ROOT" : "/usr",
                "XERCESCROOT" : "/usr/local",
                "PROTOBUF_HOME" : "/usr/local",
                "SSL_ROOT" : "/usr/local",
            }
        )

        ts_hdr_inl = ctx.actions.declare_file("{}TypeSupportClient.inl".format(file_name))
        ts_clt_hdr = ctx.actions.declare_file("{}TypeSupportClient.hpp".format(file_name))
        ts_clt_src = ctx.actions.declare_file("{}TypeSupportClient.cpp".format(file_name))
        ts_srv_hdr = ctx.actions.declare_file("{}TypeSupportServer.hpp".format(file_name))
        ts_srv_src = ctx.actions.declare_file("{}TypeSupportServer.cpp".format(file_name))
        # files.append(ts_hdr_inl)
        # files.append(ts_clt_hdr)
        # files.append(ts_clt_src)
        # files.append(ts_srv_hdr)
        # files.append(ts_srv_src)


        tao_ts_command = "tao_idl --idl-version 4 --unknown-annotations ignore  -in -Sa -St"
        tao_ts_command += " "
        tao_ts_command += "-ae -GC "
        tao_ts_command += " "
        tao_ts_command += "-Wb,pre_include=ace/pre.h -Wb,post_include=ace/post.h"
        ## tao_ts_command += " -I{} -I{} -I{} -I{} ".format(ACE_ROOT,TAO_ROOT,DDS_ROOT,full_outdir)
        tao_ts_command += " "
        tao_ts_command += " -ci Client.inl -hc Client.hpp -cs Client.cpp -hs Server.hpp -ss Server.cpp  -hT ServerTemplateSkeleton.hpp -sT ServerTemplateSkeleton.cpp "
        tao_ts_command += " "
        tao_ts_command += " {} -o {} ".format(idl_file.path,full_outdir)

        ctx.actions.run_shell(
            outputs = [
                ts_hdr_inl, 
                ts_clt_hdr, 
                ts_clt_src, 
                ts_srv_hdr, 
                ts_srv_src
            ],
            inputs = [tsidl],
            command = tao_ts_command,
            progress_message = "TAO IDL Generating TypeSupport srs from {} in folder {}".format(tsidl,full_outdir),
            use_default_shell_env = True,
            env = {
                "PATH": "$PATH:/usr/loacal/bin",
                "ACE_ROOT" : "/usr/local/share/ace",
                "TAO_ROOT" : "/usr/local/share/tao",
                "DDS_ROOT" : "/usr/local/share/dds",
                "CIAO_ROOT" : "/usr/local/share/ciao",
                "DANCE_ROOT" : "/usr/local/share/dance",
                "LD_LIBRARY_PATH" :" $LD_LIBRARY_PATH:/usr/local/lib/:/opt/dds/opendds/lib",
                "CPATH" : "$CPATH:/opt/dds/opendds/include:/usr/local/include",
                "BOOST_ROOT" : "/usr/local",
                "GLIB_ROOT" : "/usr",
                "XERCESCROOT" : "/usr/local",
                "PROTOBUF_HOME" : "/usr/local",
                "SSL_ROOT" : "/usr/local",
            }
        )

        # return [
            # DefaultInfo(files = depset(out_files)),
            # OutputGroupInfo(
                # cc = depset([f for f in out_files if f.path.endswith(".cc")]),
                # h = depset([f for f in out_files if f.path.endswith(".h")]),
            # ),
        # ]

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
