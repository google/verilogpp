module sink_one(
  input logic foo
);

logic lint_unused_signal;
assign lint_unused_signal = |{foo};

endmodule : drive_one
