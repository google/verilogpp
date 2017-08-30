// A module with unpacked data in it's interface.

module unpacked (
  input logic clk,
  input logic reset_n,
  input logic [7:0] foo [0:5],
  input logic foo_en[0:5],
  output logic [7:0] bar
);

foo i foo

endmodule

