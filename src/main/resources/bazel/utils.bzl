def basename(p):
    return p.rpartition("/")[-1]

def dirname(p):
    dirname, sep, fname = p.rpartition("/")
    if dirname:
        return dirname.rstrip("/")
    else:
        return sep

def dropExtension(p):
    "TODO: handle multiple . in name"
    return p.partition(".")[0]


def opd_bin_tool(name):
    _clang_tool(
        name = name,
        tool = "@llvm_toolchain//:bin/" + name,
        visibility = ["//visibility:public"],
    )
