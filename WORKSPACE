workspace(name = "cfscom")

load("//src/main/resources/bazel:repositories.bzl", "cfs_com_repositories")
cfs_com_repositories()

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@rules_proto_grpc//:repositories.bzl", "rules_proto_grpc_toolchains", "rules_proto_grpc_repos")
rules_proto_grpc_toolchains()
rules_proto_grpc_repos()

load("@rules_proto_grpc//cpp:repositories.bzl", rules_proto_grpc_cpp_repos="cpp_repos")
rules_proto_grpc_cpp_repos()

load("@com_github_atlassian_bazel_tools//multirun:deps.bzl", "multirun_dependencies")
multirun_dependencies()

# load("@bazel_federation//:repositories.bzl",
     # "bazel_stardoc",
     # "rules_cc",
     # "rules_java",
     # "rules_pkg",
     # "rules_python",
# )