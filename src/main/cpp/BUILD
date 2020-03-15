licenses(["notice"])
exports_files(["LICENSE"])
package(default_visibility = ["//visibility:public"])

load(
    "@rules_cc//cc:defs.bzl",
    "cc_binary",
    "cc_library"
)

load(
    "@rules_pkg//:pkg.bzl",
    "pkg_tar",
    "pkg_deb"
)

load(
    "//src/main/resources/bazel:copts.bzl",
    "DEFAULT_COPTS",
    "TEST_COPTS",
    "EXCEPTIONS_FLAG",
    "EXCEPTIONS_FLAG_LINKOPTS",
)

cc_library(
    name = "cfs-com-main",
    srcs = [
        "cfs/com/corba/VarInterface.cpp",
        "cfs/com/demo/sensors/RandomGenerator.cpp",
    ],

    hdrs = [
        "cfs/com/corba/VarInterface.hpp",
        "cfs/com/demo/sensors/RandomGenerator.hpp",
    ],

    copts = DEFAULT_COPTS + [
        "-DLOG_LEVEL=1",
        "-lapr-1",
        "-laprutil-1",
        "-llog4cxx",
        "-D_REENTRANT",
        "-I/usr/local/include/",
    ],

    linkopts = [
        "-L/usr/local/lib",
    ],

	includes = [
		".",
	],
)

#cc_library(
#    name = "lib",
#    srcs = ["x.cc"],
#    hdrs = [":gen_header"],
#)

#genrule(
#    name = "gen_header",
#    srcs = [],
#    outs = ["x.h"],
#    cmd = "echo 'int x();' > $@",
#)

