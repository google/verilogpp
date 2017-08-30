// bar is just an empty module with some interesting ports.

typedef struct {
  logic foo;
  logic bar;
} my_struct_s;

module signed_thing (
  input wire clk,
  input wire reset_n,
  input my_struct_s mine,
  input wire signed [7:0] foo,
  input wire signed [7:0] [7:0] bar
);

endmodule
