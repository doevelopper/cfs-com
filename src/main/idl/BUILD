licenses(["notice"])
exports_files(["LICENSE"])
package(default_visibility = ["//visibility:public"])

load("//src/main/resources/bazel/opendds:generate_idl.bzl", "tao_idl_gen")

tao_idl_gen(
    name = "cfs-com-idl-main",
    idls = [
        "cfs/com/Messenger.idl",
        "cfs/com/Msg.idl",
    ],
)

#load(
#    "@rules_cc//cc:defs.bzl",
#    "cc_binary",
#    "cc_library",
#)

#cc_library(
#    name = "lib",
#    #    srcs = ["x.cc"],
#    hdrs = [":gen_header"],
    #-lOpenDDS_Rtps_Udp -lOpenDDS_Rtps -lOpenDDS_Multicast -lOpenDDS_Udp -lOpenDDS_Tcp -lOpenDDS_InfoRepoDiscovery -lOpenDDS_Dcps -lTAO_BiDirGIOP -lTAO_PI -lTAO_CodecFactory -lTAO_PortableServer -lTAO_AnyTypeCode -lTAO -lACE
    #LDLIBS:=-lOpenDDS_Rtps -lOpenDDS_Rtps_Udp -lOpenDDS_InfoRepoDiscovery -lOpenDDS_Dcps -lTAO_BiDirGIOP -lTAO_PI -lTAO_CodecFactory -lTAO_PortableServer -lTAO_AnyTypeCode -lTAO -lACE
#)

#genrule(
#    name = "gen_header",
#    srcs = [],
#    outs = ["x.h"],
#    cmd = "echo 'int x();' > $@",
#)

#create_dirs:
#	@mkdir -p $(GEN_DIR)
#	@mkdir -p $(OBJ_DIR)

#.PHONY: idl_gen
#idl_gen: create_dirs
#	@echo "Invoking tao_idl"
#	@$(TAO_IDL) -Wb,pre_include=$(ACE_ROOT)/ace/pre.h -Wb,post_include=$(ACE_ROOT)/ace/post.h
#		-I$(TAO_ROOT) -Sa -St -I$(DDS_ROOT) Messenger.idl -o $(GEN_DIR)
#	@echo "Invoking opendds_idl"
#	@$(OPENDDS_IDL) -Sa -St Messenger.idl -o $(GEN_DIR)
#	@echo "Generating TypeSupport"
#	@$(TAO_IDL) -Wb,pre_include=$(ACE_ROOT)/ace/pre.h -Wb,post_include=$(ACE_ROOT)/ace/post.h
#		-I$(TAO_ROOT) -Sa -St -I$(DDS_ROOT) $(GEN_DIR)/MessengerTypeSupport.idl -o $(GEN_DIR) $(TAO_INCLUDES)
