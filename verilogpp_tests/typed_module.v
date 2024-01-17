// An example of a module with a parameterized type.

module typed_moduled#(type TYPE_T = logic [255:0],
                      integer Mode = 0) (
  input logic clk,
  input logic rst_n,
  input TYPE_T fwd_data,
  input logic fwd_valid,
  output logic fwd_ready,
  output TYPE_T rev_data,
  output logic rev_valid,
  input logic rev_ready);

assign rev_data = fwd_data;
assign rev_valid = fwd_valid;
assign fwd_ready = rev_ready;

endmodule : typed_module
