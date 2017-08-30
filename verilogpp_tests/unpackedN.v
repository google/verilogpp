// A module with unpacked data in it's interface.

module unpackedN #(
  paramter N = 6
) (
  input logic clk,
  input logic reset_n,
  input logic [7:0] foo [0:N-1],
  input logic foo_en[0:N-1],
  output logic [7:0] bar
);

foo i foo

endmodule

