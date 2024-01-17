module drive_one(
  input logic [1:0] foo
);

logic lint_unused_signal;
assign lint_unused_signal = |{foo};

endmodule : drive_one
