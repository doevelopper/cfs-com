load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library", "cc_test")
load("@rules_pkg//:pkg.bzl", "pkg_deb", "pkg_tar")

licenses(["notice"])  # Apache License

cc_test(
    name = "cfs-com-unit-test.bin",
    srcs = [
        "cfs/com/unitTest.cpp",
        "cfs/com/Test.cpp",
        "cfs/com/Test.hpp",
        #"cfs/com/GTestEventListener.cpp",
        #"cfs/com/GTestEventListener.hpp",
        #"cfs/com/demo/sensors/RandomGeneratorTest.cpp",
        #"cfs/com/demo/sensors/RandomGeneratorTest.hpp",
        #"cfs/com/ExceptionTest.cpp",
        #"cfs/com/ExceptionTest.hpp",
    ],
    copts = [
        "-std=c++17",
        "-DLOG_LEVEL=1",
        "-D_REENTRANT",
        "-I/usr/local/include/",
    ],
    includes = [
        ".",
    ],
    linkopts = [
        "-L/usr/local/lib",
        "-lapr-1",
        "-laprutil-1",
        "-llog4cxx",
        "-lgtest",
        "-lgmock",
        "-lpthread",
    ],
    deps = [
        "//src/main/cpp:cfs-com-main",
    ],

    #data = [
    #    "//src/main/resources/configs:log4cxx.xml",
    #],
)
