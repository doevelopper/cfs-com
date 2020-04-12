licenses(["notice"])

exports_files(["LICENSE"])

package(default_visibility = ["//visibility:public"])

load("//src/main/resources/bazel/opendds:generate_idl.bzl", "idl_gen")


idl_gen(
    name = "cfs-com-idl-main",
    idls = [
        "cfs/com/Messenger.idl",
        "cfs/com/Msg.idl",
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
