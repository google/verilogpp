#!/bin/bash
#
# Check that the README.md for verilogpp that is in source control is always
# up-to-date.

source gbash.sh || exit 1
source module gbash_unit.sh || exit 1

readonly GEN_README="${TEST_TMPDIR}"/generated.README.md
readonly CUR_README="${TEST_SRCDIR}"/google3/hardware/chips/infra/verilogpp/README.md

function test::up_to_date() {
  # regenerate README.md
  "${TEST_SRCDIR}"/google3/hardware/chips/infra/verilogpp/verilogpp \
    --mdhelp > "${GEN_README}"

  CHECK_FILE -a "${GEN_README}"

  # compare against existing README.md
  EXPECT_FILE_CONTENT_EQ "${GEN_README}" "${CUR_README}"
}

gbash::unit::main "$@"
