module unused_inout_port_2 (
  input  logic rst_n,
  input  logic [7:0] data_in,
  inout  logic [3:0] io_port_a,
  inout  logic       io_port_b,
  output logic [7:0] data_out
);

  assign data_out = data_in;
  assign io_port_a = 4'b0000; // This port is assigned, so it's used.
  // io_port_b is declared but neither read nor assigned.

endmodule
