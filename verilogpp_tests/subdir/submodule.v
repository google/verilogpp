// the submodule says bloop bloop bloop

module submodule #(
  parameter ID = 0
) (
  input wire clk,
  input wire reset_n,

  input wire dive,
  input wire ascend,
  output logic [31:0] fathoms_deep
);

clocking cb;
  output wire THIS_SHOULD_NOT_SHOW_UP_IN_INTERFACE;
  input wire NOR_SHOULD_THIS;
endclocking

endmodule
