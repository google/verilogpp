// bar is just an empty module with some interesting ports.

module non_ansi #(
  parameter int ID = 0
) (
	clk,
	a,
	b,
	c,
	y
);

localparam WIDTH = 32;

localparam BYTES = WIDTH/8;

function int foo(int x, int y);
	return x + y;
endfunction : foo

input logic clk;


input wire [BYTES-1:0] a;
input wire b;
input wire [WIDTH-1:0] c;
output wire y;

assign y = b;

endmodule
