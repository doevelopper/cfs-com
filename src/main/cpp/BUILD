
licenses(["notice"])
exports_files(["LICENSE"])
load("//src/main/resources/bazel:cpplint.bzl", "cpplint")
package(default_visibility = ["//visibility:public"])

load("@rules_cc//cc:defs.bzl",
    "cc_binary",
    "cc_library"
)

load("@rules_pkg//:pkg.bzl",
    "pkg_tar",
    "pkg_deb"
)

load("//src/main/resources/bazel:copts.bzl",
    "DEFAULT_COPTS",
    "TEST_COPTS",
    "EXCEPTIONS_FLAG",
    "EXCEPTIONS_FLAG_LINKOPTS",
)

load("//src/main/resources/bazel:tao.bzl",
    "tao_idl_gen",
)

# cc_import(
    # name = "opendds",
    # hdrs = glob([
        # "/opt/dds/opendds/include/**/*.h",
        # "/opt/dds/opendds/include/**/*.hpp",
    # ]),
   ##static_library = "lib.a",
    # shared_library = [
        # "/opt/dds/opendds/lib/libACE.so",
        # "/opt/dds/opendds/lib/tao_java.jar",
        # "/opt/dds/opendds/lib/OpenDDS_DCPS.jar",
        # "/opt/dds/opendds/lib/i2jrt.jar",
        # "/opt/dds/opendds/lib/libACE.so",
        # "/opt/dds/opendds/lib/libACE_XML_Utils.so",
        # "/opt/dds/opendds/lib/libOpenDDS_DCPS_Java.so",
        # "/opt/dds/opendds/lib/libOpenDDS_Dcps.so",
        # "/opt/dds/opendds/lib/libOpenDDS_FACE.so",
        # "/opt/dds/opendds/lib/libOpenDDS_Federator.so",
        # "/opt/dds/opendds/lib/libOpenDDS_InfoRepoDiscovery.so",
        # "/opt/dds/opendds/lib/libOpenDDS_InfoRepoLib.so",
        # "/opt/dds/opendds/lib/libOpenDDS_InfoRepoServ.so",
        # "/opt/dds/opendds/lib/libOpenDDS_Model.so",
        # "/opt/dds/opendds/lib/libOpenDDS_Multicast.so",
        # "/opt/dds/opendds/lib/libOpenDDS_QOS_XML_XSC_Handler.so",
        # "/opt/dds/opendds/lib/libOpenDDS_Rtps.so",
        # "/opt/dds/opendds/lib/libOpenDDS_RtpsRelay.so",
        # "/opt/dds/opendds/lib/libOpenDDS_Rtps_Udp.so",
        # "/opt/dds/opendds/lib/libOpenDDS_Security.so",
        # "/opt/dds/opendds/lib/libOpenDDS_Shmem.so",
        # "/opt/dds/opendds/lib/libOpenDDS_Tcp.so",
        # "/opt/dds/opendds/lib/libOpenDDS_Udp.so",
        # "/opt/dds/opendds/lib/libOpenDDS_monitor.so",
        # "/opt/dds/opendds/lib/libTAO.so",
        # "/opt/dds/opendds/lib/libTAO_AnyTypeCode.so",
        # "/opt/dds/opendds/lib/libTAO_Async_IORTable.so",
        # "/opt/dds/opendds/lib/libTAO_BiDirGIOP.so",
        # "/opt/dds/opendds/lib/libTAO_CSD_Framework.so",
        # "/opt/dds/opendds/lib/libTAO_CSD_ThreadPool.so",
        # "/opt/dds/opendds/lib/libTAO_CodecFactory.so",
        # "/opt/dds/opendds/lib/libTAO_Codeset.so",
        # "/opt/dds/opendds/lib/libTAO_DynamicInterface.so",
        # "/opt/dds/opendds/lib/libTAO_IDL_BE.so",
        # "/opt/dds/opendds/lib/libTAO_IDL_FE.so",
        # "/opt/dds/opendds/lib/libTAO_IORManip.so",
        # "/opt/dds/opendds/lib/libTAO_IORTable.so",
        # "/opt/dds/opendds/lib/libTAO_ImR_Client.so",
        # "/opt/dds/opendds/lib/libTAO_Messaging.so",
        # "/opt/dds/opendds/lib/libTAO_PI.so",
        # "/opt/dds/opendds/lib/libTAO_PortableServer.so",
        # "/opt/dds/opendds/lib/libTAO_Svc_Utils.so",
        # "/opt/dds/opendds/lib/libTAO_Valuetype.so",
        # "/opt/dds/opendds/lib/libidl2jni_runtime.so",
        # "/opt/dds/opendds/lib/libtao_java.so",
    # ],
# )

#tao_idl_gen(
#    name = "idl_generated",
#    src = "Sensor.idl",
#)

cc_library(
    name = "cfs-com-main",
    srcs = [
#        "cfs/com/Initialize.cpp",
        "cfs/com/Exception.cpp",
        "cfs/com/Shutdown.cpp",
        "cfs/com/ShutdownSubject.cpp",
        "cfs/com/Component.cpp",
        "cfs/com/AbstractTask.cpp",
        "cfs/com/corba/VarInterface.cpp",
        "cfs/com/DataReader.cpp",
        "cfs/com/DataWriter.cpp",
        #"cfs/com/Participant.cpp",
        #"cfs/com/ParticipantFactory.cpp",
        "cfs/com/Publisher.cpp",
        "cfs/com/PublisherListener.cpp",
        "cfs/com/Subscriber.cpp",
        "cfs/com/SubscriberListener.cpp",
        "cfs/com/Topic.cpp",
        "cfs/com/demo/sensors/RandomGenerator.cpp",
    ],

    hdrs = [
#        "cfs/com/Initialize.hpp",
        "cfs/com/Exception.hpp",
        "cfs/com/Shutdown.hpp",
        "cfs/com/ShutdownSubject.hpp",
        "cfs/com/Component.hpp",
        "cfs/com/AbstractTask.hpp",
        "cfs/com/corba/VarInterface.hpp",
        "cfs/com/DataReader.hpp",
        "cfs/com/DataWriter.hpp",
        #"cfs/com/Participant.hpp",
        #"cfs/com/ParticipantFactory.hpp",
        "cfs/com/Publisher.hpp",
        "cfs/com/PublisherListener.hpp",
        "cfs/com/Subscriber.hpp",
        "cfs/com/SubscriberListener.hpp",
        "cfs/com/Topic.hpp",
        "cfs/com/demo/sensors/RandomGenerator.hpp",
        "cfs/com/corba/CorbaIdlTypes.hpp",
        "cfs/com/TypeTraits.hpp",
    ],

    copts = DEFAULT_COPTS + [
        "-DLOG_LEVEL=1",
        "-lapr-1",
        "-laprutil-1",
        "-llog4cxx",
        "-D_REENTRANT",
        "-I/usr/local/include/",
    ],

    linkopts = [
        "-L/usr/local/lib",
        "-L/opt/dds/opendds/lib/",
    ],

	includes = [
		".",
	],

    #deps = [
        ##"@opendds_package//src/main/resources/bazel:ace_tao_opendds",
        #"@opendds_package//:ace_tao_opendds",
    #],
    #deps = [":private"],
)

#cc_library(
#    name = "private",
#    textual_hdrs = ["src/main/cpp/cfs/com/utils/Traits.inl"],
#)

cc_binary(
    name = "cfs-com-main.bin",
    srcs = ["cfs/com/main.cpp"],
    copts = [
       "-std=c++17",
    ],

    deps = [
        ":cfs-com-main",
    ],
)


#cc_library(
#    name = "lib",
#    srcs = ["x.cc"],
#    hdrs = [":gen_header"],
#)

#genrule(
#    name = "gen_header",
#    srcs = [],
#    outs = ["x.h"],
#    cmd = "echo 'int x();' > $@",
#)

pkg_tar(
    name = "cfs-com-main-libs",
    strip_prefix = "/src/main/cpp",
    package_dir = "/opt/lib",
    srcs = ["//src/main/cpp:cfs-com-main"],
    mode = "0755",
)

pkg_tar(
    name = "cfs-com-main-hdrs-pkg",
#    testonly = True,
    srcs = glob([
        "**/*.hpp",
    ]),
    # extension = "tar.gz",
    package_dir = "/opt/include",
    strip_prefix = "/src/main/cpp",
    tags = ["manual"],
    visibility = ["//visibility:public"],
    mode = "0644",
)

pkg_tar(
    name = "cfs-com-main-bin-pkg",
#    testonly = True,
    srcs = [
        # ":cfs-algo-main",
        ":cfs-com-main.bin",
    ],
    # extension = "tar.gz",
    package_dir = "/opt/bin",
    strip_prefix = "/src/main/cpp",
    tags = ["manual"],
)

pkg_tar(
    name = "cfs-com",
    extension = "tar.gz",
    deps = [
        ":cfs-com-main-libs",
        ":cfs-com-main-hdrs-pkg",
        ":cfs-com-main-bin-pkg",
    ],
)

pkg_deb(
    name = "cfs-com-main-deb-pkg",
    testonly = True,
    architecture = "amd64",
    data = ":cfs-com",
    description = "Core Flight System Communication layer",
    homepage = "https://gitlab.com/doevelopper/cfs-com",
    maintainer = "Adrien H.",
    package = "CFS COM",
    tags = ["manual"],
    version = "0.0.1",
    visibility = ["//visibility:public"],
)


#cpplint()

