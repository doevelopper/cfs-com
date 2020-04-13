licenses(["notice"])

exports_files(["LICENSE"])

package(default_visibility = ["//visibility:public"])

load("//src/main/resources/bazel/opendds:generate_idl.bzl", "idl_library")


idl_library(
    name = "Messenger",
    idls = [
        "cfs/com/demo/msg/Messenger.idl",
#        "cfs/com/Msg.idl",
    ],

#    deps = [
#	     "@acelib//:ace"
#	     "@taolib//:tao"
#    ],
#    deps = [
#        ":test_grpc",
#    ],
#    out_path = "external/proto_targets",
#    visibility = ["//visibility:public"]

)
