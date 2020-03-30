
load("@bazel_skylib//lib:versions.bzl", "versions")
load("@rules_cc//cc:defs.bzl", "cc_library")
# for flags https://github.com/objectcomputing/OpenDDS/blob/master/cmake/tao_idl_sources.cmake
BASE_IDL_FLAGS = " ".join([ 
    "-Sa",
    "-St",
    "--idl-version 4",
])

  # idlflags      += -Wb,export_include=FaceMessenger_Export.h \
                   # -Wb,export_macro=FaceMessenger_Export
  # dcps_ts_flags += -Wb,export_include=FaceMessenger_Export.h \
                   # -Wb,export_macro=FaceMessenger_Export
    # "-Wb,stub_export_macro=CFS_COM_Export",
    # "-Wb,export_include=CFS_COM_Export.h",
    # "-Wb,export_macro=CFS_COM_Export",
    # "-Wb,versioning_begin=TAO_BEGIN_VERSIONED_NAMESPACE_DECL",
    # "-Wb,versioning_end=TAO_END_VERSIONED_NAMESPACE_DECL",

TAO_IDL_FLAGS = " ".join([ 
    "-Wb,pre_include=ace/pre.h",
    "-Wb,post_include=ace/post.h",
    "-Gos",
    "-Sg",
    "--unknown-annotations ignore",
    "-Sch",
    "-Sci",
    "-Scc",
    "-Ssh", 
    "-SS",
    "-GA",
    "-GT",
    "-GX",
    "-Gxhst",
    "-Gxhsk",
    # -I${TAO_INCLUDE_DIR}
])

TAO_CORBA_IDL_FLAGS = " ".join([  
    "-DCORBA_E_MICRO",
    "-Gce",
]) 

DDS_IDL_FLAGS  = " ".join([ 
    "-Sa",
    "-St",
])
##
# Runs a command and either fails or returns an ExecutionResult
#
def _execute_and_check_result(ctx, command, **kwargs):
    res = ctx.execute(command, **kwargs)
    if res.return_code != 0:
        fail("""Failed to execute command: `{command}`{newline}Exit Code: {code}{newline}STDERR: {stderr}{newline}""".format(
            command = command,
            code = res.return_code,
            stderr = res.stderr,
            newline = "\n"
           ) 
       )
    return res

def _GetPath(ctx, path):
    if ctx.label.workspace_root:
        return ctx.label.workspace_root + "/" + path
    else:
        return path

def _IsNewExternal(ctx):
    return ctx.label.workspace_root.startswith("../")

def _GenDir(ctx):
    if _IsNewExternal(ctx):
        return ctx.genfiles_dir.path + (
            "/" + ctx.attr.idls[0] if ctx.attr.idls and ctx.attr.idls[0] else ""
        )

def _SourceDir(ctx):
    if not ctx.attr.idls:
        return ctx.label.workspace_root
    if not ctx.attr.idls[0]:
        return _GetPath(ctx, ctx.label.package)
    if not ctx.label.package:
        return _GetPath(ctx, ctx.attr.idls[0])
    # return _GetPath(ctx, ctx.label.package + "/" + ctx.attr.idls[0])

def _RelativeOutputPath(path, include, dest = ""):
    if include == None:
        return path

    if not path.startswith(include):
        fail("Include path %s isn't part of the path %s." % (include, path))

    if include and include[-1] != "/":
        include = include + "/"
    if dest and dest[-1] != "/":
        dest = dest + "/"

    path = path[len(include):]
    return dest + path

# https://docs.bazel.build/versions/master/skylark/rules.html#actions
# https://docs.bazel.build/versions/master/skylark/lib/actions.html


def _tao_idl_gen_impl(ctx):
    """General implementation for generating tao idl"""
    idls = ctx.files.idls
    source_dir = _SourceDir(ctx)
    # gen_dir = _GenDir(ctx).rstrip("/")
    print("source dir {} has.....".format(source_dir))
    print("source dir {} has.....".format(ctx.label.package))

    for input in ctx.files.idls:
        namesis = input.basename
        command = "tao_idl -in -hc C.h -cs C.cpp -ci C.i.h -hs S.h -hT S_T.h -ss S.cpp -sT S_T.cpp -si S.i.h {} ".format(input)
        output_file = ctx.actions.declare_file(
        ctx.actions.run_shell(
            command = command,
            use_default_shell_env = True,
            inputs = [input],
            progress_message = "Processing file {} ".format(input),
            mnemonic = "idl_gen",
            env = {
                "PATH": "/home/pc/workarea/software/dotnet",
                "ACE_ROOT" : "/opt/dds/opendds/share/ace",
                "TAO_ROOT" : "/opt/dds/opendds/share/tao",
                "DDS_ROOT" : "/opt/dds/opendds/share/dds",
                "LD_LIBRARY_PATH" :" $LD_LIBRARY_PATH:/opt/dds/opendds/lib",
                "SSL_ROOT" : "/usr/local",
            }
        )

    # print("Target {} has.....".format(gen_dir))

    # pass
    # source = ctx.actions.declare_directory(ctx.attr.name + "-idls")
    # output = ctx.actions.declare_directory(ctx.attr.name + "-idls-gen")
    # ctx.actions.run_shell(
        # inputs = ctx.files.idls,
        # outputs = [source],
        # command = ("mkdir -p %s\n" % (source.path)) +
                  # "\n".join([
                      # "/opt/dds/opendds/bin/tao_idl %s -o %s" % (src.path, source.path)
                      # for src in ctx.files.idls
                  # ]),
        # env = {
            # "PATH": "/home/pc/workarea/software/dotnet",
            # "ACE_ROOT" : "/opt/dds/opendds/share/ace",
            # "TAO_ROOT" : "/opt/dds/opendds/share/tao",
            # "DDS_ROOT" : "/opt/dds/opendds/share/dds",
            # "LD_LIBRARY_PATH" :" $LD_LIBRARY_PATH:/opt/dds/opendds/lib",
            # "SSL_ROOT" : "/usr/local",
        # }
    # )
    # outputfiles = []

    # print("Target {} has.....".format(ctx.label))
    # print("Name {} has.....".format(ctx.attr.name))

    # for i, d in enumerate(ctx.attr.idls):
        # print(" {}. IDL = {}".format(i + 1, d.label))

    # for input in ctx.files.idls:
        # namesis = input.basename
        # idl_out = namesis.split(".")[0]
        # myoutputfile = ctx.actions.declare_file(namesis)
        # print("input path %s" % input.path)
        # print("output name %s" % namesis)
        # print("output name %s" % idl_out)
        # print("input dirname %s" % input.dirname)
        # print("input root.path %s" % input.root.path)
        # print("input short_path %s" % input.short_path)
        # ctx.actions.run_shell(
            # inputs = ctx.files.srcs,
        # outputfiles.append(idl_out + "Client.hpp")
        # outputfiles.append(idl_out + "Client.cpp")
        # outputfiles.append(idl_out + "Server.hpp")
        # outputfiles.append(idl_out + "Server.cpp")
        # outputfiles.append(idl_out + "ServerTemplateSkeleton.hpp")
        # outputfiles.append(idl_out + "ServerTemplateSkeleton.cpp")
        # ctx.actions.run_shell(
            # outputs = [outputfiles],
            # inputs = [input],
            # command = "/opt/dds/opendds/bin/tao_idl "% (input.path, myoutputfile.path),
            # env = {
                # "PATH": "/home/pc/workarea/software/dotnet",
                # "ACE_ROOT" : "/opt/dds/opendds/share/ace",
                # "TAO_ROOT" : "/opt/dds/opendds/share/tao",
                # "DDS_ROOT" : "/opt/dds/opendds/share/dds",
                # "LD_LIBRARY_PATH" :" $LD_LIBRARY_PATH:/opt/dds/opendds/lib",
                # "SSL_ROOT" : "/usr/local",
            # }
        # )

    #print("  files = " + str([f.path for f in d.files.to_list()]))
    #print(dir(ctx))  # prints all the fields and methods of ctx

    print("Gen dir: {}".format(ctx.genfiles_dir.path))
    print("GENDIR: {}".format(ctx.var["GENDIR"] ))

#    idl_input = ctx.label.name
#    idl_output = ctx.outputs.idl
#    src_list = []
#    for src in ctx.files.srcs:
#        src_list += [src.path]
#    cmd = [
#        "mkdir -vp %s" % idl_input,
#        "tao_idl --help"
#    ]

#    ctx.action(
#        inputs = ctx.files.srcs,
#        outputs = [idl_output],
#        command = "\n".join(cmd)
#    )

#    out = ctx.actions.declare_directory(ctx.label.name + "_generated_idl")
# The command may only access files declared in inputs.
#    ctx.actions.run_shell(
#        arguments = [qemu, machine, cpu, target],
#        command="-Wb,pre_include=ace/pre.h -Wb,post_include=ace/post.h -I$TAO_ROOT -I$DDS_ROOT -I$QCE_ROOT -in -hc Client.hpp -hs Server.hpp -hT ServerTemplateSkeleton.hpp -cs Client.cpp -ss Server.cpp -sT ServerTemplateSkeleton.cpp --idl-version 4 -Sa -St $1 -o $(GENDIR)"
#    )

tao_idl_gen = rule(
    implementation = _tao_idl_gen_impl,
    attrs = {
#        "idls": attr.label_list(allow_empty = False),
        "idls": attr.label_list(
             allow_files = [".idl"],
             doc = "The .IDL files to compile using tao_idl."
        ),
        # "idl_gen": attr.label(
            # executable = True,
            # cfg = "host",
            # allow_files = True,
            # default = Label("opt/dds/opendds/bin/tao_idl"),
        # ),
        "deps": attr.label_list(allow_files = False),
        "flags": attr.label_list(allow_files = False),
        #"out": attr.output(mandatory = True, doc = "The generated file"),
        "depends": attr.string_list(default = []),
        "depends_file": attr.label(allow_single_file = True),
    },
    # outputs = {
        # "clthdr": "{}Client.hpp".format(basename)),
        # "clthdr": "%{name}Client.hpp",
        # "cltsrc": "%{name}Client.cpp",
        # "srvhdr": "%{name}Server.hpp",
        # "srvsrc": "%{name}Server.cpp",
        # "skelhdr": "%{name}ServerTemplateSkeleton.hpp",
        # "skelsrc": "%{name}ServerTemplateSkeleton.cpp",
     # },
    output_to_genfiles = True,
)
