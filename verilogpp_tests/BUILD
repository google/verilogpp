# Regression tests for verilogpp

sh_test(
    name = "verilogpp_files_test",
    size = "medium",
    srcs = ["verilogpp_files.sh"],
    data = [
        "verilogpp_files.t",
        "//hardware/chips/infra/verilogpp:verilogpp",
        "test_utils.pm",
        "verilogpp.fortest.rc",
        "preproc.manifest.expected",
    ] + glob(["*.vpp"]) + glob(["*.v"]),
)

sh_test(
    name = "readme_up_to_date_test",
    size = "small",
    srcs = ["readme_up_to_date.sh"],
    data = [
        "//hardware/chips/infra/verilogpp",
        "//hardware/chips/infra/verilogpp:README.md",
    ],
    deps = [
        "//util/shell/gbash",
        "//util/shell/gbash:unit",
    ],
)
