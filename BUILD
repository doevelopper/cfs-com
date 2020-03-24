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

COPTS = [
    "-D_GNU_SOURCE",
] + select({
        ":with_opendds": ["-DOPENDDS=1"],
        "//conditions:default": [""],
}) + select({
        ":with_fastrtps": [""],
        "//conditions:default": [""],
}) + select({
        ":with_rtidds": ["-DRTI_LINUX -DRTIDDS"],
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
