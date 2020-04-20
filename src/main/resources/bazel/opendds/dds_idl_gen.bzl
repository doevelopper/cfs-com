def _idl_library_impl(ctx):
    pass

_idl_library = rule(
    attrs = {
        "idls": attr.label_list(allow_files = [".idl"]),
        "dds_ventor": attr.string(),
    },
    implementation = _idl_library_impl,
)

def generic_idl_library(**kwargs):
    _idl_library(
        dds_ventor = select({
            "@dds//vendor/type/eprosima": "fast_rtps",
            "@dds//vendor/type/adlink_ist": "vortex_opensplice",
            "@dds//vendor/type/rti": "connext_dds",
            "@dds//vendor/type/omg": "opendds",
            "@dds//vendor/type/eclipse": "cyclone_dds",
        }),
        **kwargs
    )
