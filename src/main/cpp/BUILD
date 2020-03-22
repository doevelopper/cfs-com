
licenses(["notice"])
exports_files(["LICENSE"])
load("//src/main/resources/bazel:cpplint.bzl", "cpplint")
package(default_visibility = ["//visibility:public"])

load("@rules_cc//cc:defs.bzl",
    "cc_binary",
    "cc_library"
)

load("@rules_pkg//:pkg.bzl",
    "pkg_tar",
    "pkg_deb"
)

load("//src/main/resources/bazel:copts.bzl",
    "DEFAULT_COPTS",
    "TEST_COPTS",
    "EXCEPTIONS_FLAG",
    "EXCEPTIONS_FLAG_LINKOPTS",
)

load("//src/main/resources/bazel:tao.bzl",
    "tao_idl_gen",
)

#tao_idl_gen(
#    name = "idl_generated",
#    src = "Sensor.idl",
#)

cc_library(
    name = "cfs-com-main",
    srcs = [
        "cfs/com/Exception.cpp",
        "cfs/com/corba/VarInterface.cpp",
        "cfs/com/demo/sensors/RandomGenerator.cpp",
    ],

    hdrs = [
        "cfs/com/Exception.hpp",
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
        "-L/opt/dds/opendds/lib/",
    ],

	includes = [
		".",
	],

    #deps = [
        ##"@opendds_package//src/main/resources/bazel:ace_tao_opendds",
        #"@opendds_package//:ace_tao_opendds",
    #],
    #deps = [":private"],
)

#cc_library(
#    name = "private",
#    textual_hdrs = ["src/main/cpp/cfs/com/utils/Traits.inl"],
#)

cc_binary(
    name = "cfs-com-main.bin",
    srcs = ["cfs/com/main.cpp"],
    copts = [
       "-std=c++17",
    ],

    deps = [
        ":cfs-com-main",
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

pkg_tar(
    name = "cfs-com-main-libs",
    strip_prefix = "/src/main/cpp",
    package_dir = "/opt/lib",
    srcs = ["//src/main/cpp:cfs-com-main"],
    mode = "0755",
)

pkg_tar(
    name = "cfs-com-main-hdrs-pkg",
#    testonly = True,
    srcs = glob([
        "**/*.hpp",
    ]),
    # extension = "tar.gz",
    package_dir = "/opt/include",
    strip_prefix = "/src/main/cpp",
    tags = ["manual"],
    visibility = ["//visibility:public"],
    mode = "0644",
)

pkg_tar(
    name = "cfs-com-main-bin-pkg",
#    testonly = True,
    srcs = [
        # ":cfs-algo-main",
        ":cfs-com-main.bin",
    ],
    # extension = "tar.gz",
    package_dir = "/opt/bin",
    strip_prefix = "/src/main/cpp",
    tags = ["manual"],
)

pkg_tar(
    name = "cfs-com",
    extension = "tar.gz",
    deps = [
        ":cfs-com-main-libs",
        ":cfs-com-main-hdrs-pkg",
        ":cfs-com-main-bin-pkg",
    ],
)

pkg_deb(
    name = "cfs-com-main-deb-pkg",
    testonly = True,
    architecture = "amd64",
    data = ":cfs-com",
    description = "Core Flight System Communication layer",
    homepage = "https://gitlab.com/doevelopper/cfs-com",
    maintainer = "Adrien H.",
    package = "CFS COM",
    tags = ["manual"],
    version = "0.0.1",
    visibility = ["//visibility:public"],
)


#cpplint()

