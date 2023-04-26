module locparam(clk, a, b, c);

localparam FOO = 8;

input wire [FOO-1:0] a;
input wire [2*FOO-1:0] b;
output wire [FOO-1:0] c;

endmodule : locparam
