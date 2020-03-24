workspace(
    name = "cfscom"
)

load("//src/main/resources/bazel:repositories.bzl", "cfs_com_repositories")
cfs_com_repositories()

# Check that the user has a version between our minimum supported version of
# Bazel and our maximum supported version of Bazel.
load("//src/main/resources/bazel:version.bzl", "MAX_VERSION", "MIN_VERSION", "check_version")
check_version(MIN_VERSION, MAX_VERSION)

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
