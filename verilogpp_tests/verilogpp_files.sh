#!/bin/bash

set -e

export TEST_SRCDIR="${TEST_SRCDIR}"
export TEST_TMPDIR="${TEST_TMPDIR}"

# copy over files so we can do operations in place.
cp -ruvL \
  "${TEST_SRCDIR}"/google3/hardware/chips/infra/verilogpp/* \
  "${TEST_TMPDIR}"

# run test in the temp directory.
cd "${TEST_TMPDIR}"/verilogpp_tests
chmod -R a+rwX .

echo "##########################"
echo "Starting verilogpp_files.t"
echo "##########################"
perl ./verilogpp_files.t
