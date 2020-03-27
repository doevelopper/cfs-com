cc_library(
    name = "opendds_shared",
    srcs = glob([
        "/opt/dds/opendds/lib/lib*",
    ]),
    hdrs = glob(
        [
            "/opt/dds/opendds/include/*.hpp",
        ] + [
            "/opt/dds/opendds/include/*.h",
        ] + [
            "/opt/dds/opendds/include/**/*.hpp",
        ] + [
            "/opt/dds/opendds/include/**/*.h",
        ] + [
            "/opt/dds/opendds/include/**/**/**/*.hpp",
        ] + [
            "/opt/dds/opendds/include/**/**/**/*.h",
        ] + [
            "/opt/dds/opendds/include/**/**/*.hpp",
        ] + [
            "/opt/dds/opendds/include/**/**/*.h",
        ],
    ),
    includes = [
        "/opt/dds/opendds/include",
    ],
    strip_include_prefix = "/opt/dds/opendds/include/",
    visibility = ["//visibility:public"],
)
