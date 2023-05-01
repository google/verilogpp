// the submodule says bloop bloop bloop

module module_a #(
  parameter ID = 0
) (
  input wire clk,
  input wire reset_n,

  input wire launch,
  input wire abort,
  output logic [31:0] altitude
);

clocking cb;
  output wire THIS_SHOULD_NOT_SHOW_UP_IN_INTERFACE;
  input wire NOR_SHOULD_THIS;
endclocking

endmodule
