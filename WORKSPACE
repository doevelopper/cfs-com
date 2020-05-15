workspace(
    name = "cfs_com",
)

load("//src/main/resources/bazel:repositories.bzl", "cfs_com_repositories")

cfs_com_repositories()

load("//src/main/resources/bazel:sw_qa_repositories.bzl", "qa_repositories")

qa_repositories()

# Check that the user has a version between our minimum supported version of
# Bazel and our maximum supported version of Bazel.
load("//src/main/resources/bazel:version.bzl", "MAX_VERSION", "MIN_VERSION", "check_version")

check_version(MIN_VERSION, MAX_VERSION)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@rules_proto_grpc//:repositories.bzl", "rules_proto_grpc_repos", "rules_proto_grpc_toolchains")

rules_proto_grpc_toolchains()

rules_proto_grpc_repos()

load("@rules_proto_grpc//cpp:repositories.bzl", rules_proto_grpc_cpp_repos = "cpp_repos")

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

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains()

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

load("@com_github_google_rules_install//:deps.bzl", "install_rules_dependencies")

install_rules_dependencies()

load("@com_github_google_rules_install//:setup.bzl", "install_rules_setup")

install_rules_setup()

#new_local_repository(
#    name = "opendds",
#    build_file = "//src/main/resources/bazel/opendds.BUILD",  #
#    path = "/opt/dds/opendds/include/",
#)

new_local_repository(
    name = "acelib",
    build_file_content = """
        cc_library(
            name = "ace",
            hdrs = glob([
                "/usr/local/include/ace/**/*.h"
                "/usr/local/include/ace/**/*.inl"
            ]),
            srcs = [
                "libACE.so",
#                "libACE_Compression.so",
#                "libACE_ETCL.so",
#                "libACE_INet.so",
#                "libACE_INet_SSL.so",
#                "libACE_Monitor_Control",
#                "libACE_RLECompression.so",
                "libACE_SSL.so",
                "libACE_XML_Utils.so",
#                "libAMI4CCM_lem_stub.so",
#                "libAMI4CCM_stub.so",
#                "libAMI4CCM_svnt.so",
            ],
            visibility = ["//visibility:public"],
        )
    """,
    path = "/usr/local/lib",
)

new_local_repository(
    name = "openddslib",
    build_file_content = """
        cc_library(
            name = "opendds",
            hdrs = glob([
                "/usr/local/include/CORBA/*.h"
                "/usr/local/include/Domain_Validator/*.h"
                "/usr/local/include/FACE//*.h"
                "/usr/local/include/FACE/*.hpp"
                "/usr/local/include/dds/**/*.h"
                "/usr/local/include/dds/**/*.inl"
                "/usr/local/include/dds/**/*.hpp"
            ]),
            srcs = [
                OpenDDS_Dcps
                OpenDDS_FACE
                OpenDDS_Federator
                OpenDDS_InfoRepoDiscovery
                OpenDDS_InfoRepoLib
                OpenDDS_InfoRepoServ
                OpenDDS_Model
                OpenDDS_monitor
                OpenDDS_Multicast
                OpenDDS_QOS_XML_XSC_Handler
                OpenDDS_Rtps
                OpenDDS_Rtps_Udp
                OpenDDS_Security
                OpenDDS_Shmem
                OpenDDS_Tcp
                OpenDDS_Udp
            ],

            linkopts = [
                "-lrt",
                "-lpthread",
             ],

            visibility = ["//visibility:public"],
        )
    """,
    path = "/usr/local/lib",
)

new_local_repository(
    name = "taolib",
    #build_file = "//src/main/resources/bazel:BUILD.tao",
    build_file_content = """
        package(default_visibility = ["//visibility:public"])
        cc_library(
            name = "tao",
            hdrs = glob([
                "/usr/local/include/tao/**/*.h"
                "/usr/local/include/tao/**/*.hpp"
                "/usr/local/include/tao/**/*.inl"
            ]),
            srcs = [
                "libTAO.so",
                "libTAO_AnyTypeCode.so",
                # "libTAO_Async_IORTable.so",
                "libTAO_BiDirGIOP.so",
                # "libTAO_CSD_Framework.so",
                # "libTAO_CSD_ThreadPool.so",
                # "libTAO_Catior_i.so",
                "libTAO_CodecFactory.so",
                # "libTAO_Codeset.so",
                # "libTAO_Compression.so",
                # "libTAO_CosNaming.so",
                # "libTAO_CosNaming_Serv.so",
                # "libTAO_CosNaming_Skel.so",
                # "libTAO_DiffServPolicy.so",
                # "libTAO_DynamicAny.so",
                # "libTAO_DynamicInterface.so",
                # "libTAO_Dynamic_TP.so",
                # "libTAO_ETCL.so",
                # "libTAO_EndpointPolicy.so",
                # "libTAO_FtNaming.so",
                # "libTAO_IDL3_TO_IDL2_BE.so",
                # "libTAO_IDL_BE.so",
                "libTAO_IDL_FE.so",
                # "libTAO_IFR_Client.so",
                # "libTAO_IFR_Client_skel.so",
                # "libTAO_IORInterceptor.so",
                "libTAO_IORManip.so",
                "libTAO_IORTable.so",
                "libTAO_ImR_Client.so",
                # "libTAO_Messaging.so",
                # "libTAO_Monitor.so",
                # "libTAO_ObjRefTemplate.so",
                "libTAO_PI.so",
                # "libTAO_PI_Server.so",
                # "libTAO_PortableGroup.so",
                "libTAO_PortableServer.so",
                # "libTAO_RLECompressor.so",
                # "libTAO_RTCORBA.so",
                # "libTAO_RTPortableServer.so",
                # "libTAO_RTScheduler.so",
                # "libTAO_SmartProxies.so",
                # "libTAO_Strategies.so",
                "libTAO_Svc_Utils.so",
                # "libTAO_TC.so",
                # "libTAO_TC_IIOP.so",
                # "libTAO_TypeCodeFactory.so",
                # "libTAO_Utils.so",
                # "libTAO_Valuetype.so",
                # "libTAO_ZIOP.so",
            ],

            includes = ["/usr/local/include/"],
            include_prefix = "tao",

            linkopts = [
                "-lrt",
                "-lboost_system",
                "-lpthread",
             ],

            visibility = ["//visibility:public"],

#            linkstatic = 1,
        )
    """,
    path = "/usr/local/lib",  # pkg-config --variable=libdir TAO
)

bind(
    name = "the_ace_orb",
    actual = "@taolib//:tao",
)

new_local_repository(
    name = "ace_tao_opendds_binaries",
    build_file = "src/main/resources/bazel/opendds/opendds.BUILD",
    path = "/usr/local",
)

new_local_repository(
    name = "openssl_shared",
    build_file_content = """
    cc_library(
        name = "ssl",
        hdrs = glob(["/usr/local/include/openssl/**/*.h"]),
        copts = ["-I/usr/local/include/openssl"],
        linkopts = [
            "-lcrypto",
            "-lssl"
        ],
        visibility = ["//visibility:public"],
        linkstatic = False,
)
""",
    path = "/usr/loal/lib",
)


#http_archive(
#    name = "io_rules_sdlc",
#    strip_prefix = "rules_sdlc-master",
#    urls = [
#       "https://github.com/doevelopper/rules-sdlc/archive/master.zip",
#       "https://github.com/doevelopper/rules-sdlc/archive/feature/common-cfs-bazel-scripts.zip",
#    ],
#    sha256 = "TODO",
#)

