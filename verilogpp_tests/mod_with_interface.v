// An example of a module with an interface modport

module mod_with_interfaced (
  input logic clk,
  input logic rst_n,
  axi4_if.completer axi,
  output logic [15:0] fwd_data,
  output logic fwd_valid,
  input logic fwd_ready);

assign fwd_valid = axi.wvalid;
assign fwd_data = axi.wdata;
assign axi.wready = axi.wready;

endmodule : mod_with_interface
