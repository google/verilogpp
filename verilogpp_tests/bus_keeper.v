// bar is just an empty module with some interesting ports.

module bus_keeper #(
  parameter ID = 0
) (
  input wire clk,
  input wire reset_n,

  input wire         busNNN_valid,
  input wire [31:0]  busNNN_in,
  output wire [31:0] busNNN_out
);

clocking cb;
  output wire THIS_SHOULD_NOT_SHOW_UP_IN_INTERFACE;
  input wire NOR_SHOULD_THIS;
endclocking

endmodule
