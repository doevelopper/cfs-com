
load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library", "cc_test")
load("@rules_pkg//:pkg.bzl", "pkg_tar", "pkg_deb")
load("@com_github_atlassian_bazel_tools//multirun:def.bzl", "multirun", "command")

cc_binary(

    name = "cfs-com-integration-test.bin",

    srcs = [
        "cfs/com/features/step_definitions/Steps.cpp",
        "cfs/com/features/step_definitions/Steps.hpp",
    ],

    includes = [
        ".",
    ],

    copts = [
        "-std=c++17",
        "-DLOG_LEVEL=1",
        "-lapr-1",
        "-laprutil-1",
        "-llog4cxx",
        "-D_REENTRANT",
        "-I/usr/local/include/",
    ],

    linkopts = [
        "-L/usr/local/lib",
        "-lapr-1",
        "-laprutil-1",
        "-llog4cxx",
        "-lgtest",
        "-lgmock",
        "-lpthread",
        "-lboost_thread",
        "-lboost_system",
        "-lboost_regex",
        "-lboost_date_time",
        "-lboost_program_options",
        "-lboost_filesystem",
        "-lcucumber-cpp",
    ],

    deps = [
        "//src/main/cpp:cfs-com-main",
    ],
)

pkg_tar(
    name = "cfs-com-integration-test.bin-pkg",
    # testonly = True,
    srcs = [
        ":cfs-com-integration-test.bin",
    ],
    package_dir = "/opt/bin",
    strip_prefix = "/src/it",
    tags = ["manual"],
)

pkg_tar(
    name = "cfs-com-integration-test",
    extension = "tar.gz",
    deps = [
        ":cfs-com-integration-test.bin-pkg",
    ],
)

command(
    name = "cs-integration-test",
    command = "//src/it:cfs-com-integration-test.bin",
    arguments = [
        "--port",
        "3902",
    ],
    environment = {
        "ABC": "DEF",
    },
    raw_environment = {
        "PATH": "$(pwd)/qa/atp",
    },
)

command(
    name = "cucumber-bin",
    command = "cucumber",
    arguments = [
        "--out",
        "Feature-Tests-Report.html",
        "--strict",
        "$(pwd)/features",
    ],
    environment = {
        "ABC": "DEF",
    },
    raw_environment = {
        "PATH": "$(pwd)/",
    },
)

multirun(
    name = "integration-test",
    commands = [
        ":cs-integration-test",
        ":cucumber-bin",
    ],
    #parallel = True,
)

