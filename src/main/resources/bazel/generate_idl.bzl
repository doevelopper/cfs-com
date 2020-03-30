# https://docs.bazel.build/versions/master/skylark/rules.html#actions
# https://docs.bazel.build/versions/master/skylark/lib/actions.html

def _tao_idl_gen_impl(ctx):
	source = ctx.actions.declare_directory(ctx.attr.name + "-idls")
	output = ctx.actions.declare_directory(ctx.attr.name + "-idls-gen")
	ctx.actions.run_shell(
        inputs = ctx.files.idls,
		outputs = [source],
		command = ("mkdir -p %s\n" % (source.path)) +
                  "\n".join([
                      "/opt/dds/opendds/bin/tao_idl %s -o %s" % (src.path, source.path)
                      for src in ctx.files.idls
                  ]),
		env = {
			"PATH": "/home/pc/workarea/software/dotnet",
			"ACE_ROOT" : "/opt/dds/opendds/share/ace",
			"TAO_ROOT" : "/opt/dds/opendds/share/tao",
			"DDS_ROOT" : "/opt/dds/opendds/share/dds",
			"LD_LIBRARY_PATH" :" $LD_LIBRARY_PATH:/opt/dds/opendds/lib",
			"SSL_ROOT" : "/usr/local",
		}
	)
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
        "idls": attr.label_list(allow_files = [".idl"]),
        "flags": attr.label_list(allow_files = False),
    },
)
