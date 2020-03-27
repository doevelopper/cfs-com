licenses(["notice"])  # Apache 2
package(default_visibility = ["//visibility:public"])

exports_files([
    "VERSION",
    ".clang-format",
])

filegroup(
    name = "configuration_files",
    srcs = glob([
        #"src/main/resources/configs/log4cxx.xml",
        #"//src/main/resources/configs:log4cxx.xml",
        "src/main/resources/configs/*.xml",
    ]),
)

filegroup(
    name = "nothing",
    visibility = ["//visibility:public"],
)

config_setting(
    name = "darwin",
    values = {"cpu": "darwin"},
    visibility = ["//visibility:public"],
)

config_setting(
    name = "linux",
    values = {"cpu": "linux"},
    visibility = ["//visibility:public"],
)

config_setting(
    name = "with_opendds",
    define_values = {"with_opendds": "true"},
    visibility = ["//visibility:public"],
)

config_setting(
    name = "with_fastrtps",
    define_values = {"with_fastrtps": "true"},
    visibility = ["//visibility:public"],
)

config_setting(
    name = "with_vortexdds",
    define_values = {"with_vortexdds": "true"},
    visibility = ["//visibility:public"],
)

config_setting(
    name = "with_rtidds",
    define_values = {"with_rtidds": "true"},
    visibility = ["//visibility:public"],
)

config_setting(
    name = "optimized",
    values = {"compilation_mode": "opt"},
    visibility = ["//visibility:public"],
)

filegroup(
    name = "dds_idl",
    srcs = glob(["src/main/idl/cfs/com/*.idl"]),
    visibility = ["//visibility:public"],
)

config_setting(
    name = "x86_64",
    values = {
        "define": "ARCH=x86_64",
    },
)

config_setting(
    name = "aarch64",
    values = {
        "define": "ARCH=aarch64",
    },
)

config_setting(
    name = "windows",
    values = {"cpu": "x64_windows"},
    constraint_values = ["@bazel_tools//platforms:windows"],
    visibility = ["//visibility:private"],
)

# DDS_VENDOR_RTI
# DDS_VENDOR_ADLINK_OSPL
# DDS_VENDOR_OCI
# DDS_VENDOR_MILSOFT
# DDS_VENDOR_KONGSBERG
# DDS_VENDOR_TWINOAKS
# DDS_VENDOR_LAKOTA
# DDS_VENDOR_ICOUP
# DDS_VENDOR_ETRI
# DDS_VENDOR_RTI_MICRO
# DDS_VENDOR_ADLINK_JAVA
# DDS_VENDOR_ADLINK_GATEWAY
# DDS_VENDOR_ADLINK_LITE
# DDS_VENDOR_TECHNICOLOR
# DDS_VENDOR_EPROSIMA
# DDS_VENDOR_ECLIPSE
# DDS_VENDOR_ADLINK_CLOUD

COPTS = [
    "-D_GNU_SOURCE",
    #"-DEXTERN_SYMBOL=__attribute__((__visibility__(\\"default\\")))",
] + select({
        ":with_opendds": ["-DCFS_OPENDDS_DDS=1"],
        "//conditions:default": [""],
}) + select({
        ":with_fastrtps": ["-DCFS_FASTRTPS_DDS"],
        "//conditions:default": [""],
}) + select({
        ":with_vortexdds": ["-DCFS_OPENSPLICE_DDS"],
        "//conditions:default": [""],
}) + select({
        ":with_rtidds": ["-DRTI_LINUX -DCFS_RTI_DDS"],
        "//conditions:default": [""],
})

LINKOPTS = [
    "-lpthread",
    "-lssl",
    "-lcrypto",
] + select({
    ":darwin": [""],
    "//conditions:default": [ "-lrt", ],
}) + select({
        ":with_opendds": [
            "-lACE",
        ],
        "//conditions:default": [],
}) + select({
        ":with_rtidds": [
            "-ldummy",
        ],
        "//conditions:default": [],
})

#genrule(
#    name = "assert_optimized",
#    outs = ["dummy.txt"],
#    cmd = select({
#        ":optimized": "echo > $@",
#        "//conditions:default": """echo 'ERROR: Cartographer must be built with \
#`-c opt` or it will not produce results for real-time.' 1>&2; false""",
#    }),
#    visibility = ["//visibility:public"],
#)

load("@com_github_bazelbuild_buildtools//buildifier:def.bzl", "buildifier")

buildifier(
    name = "buildifier",
)

