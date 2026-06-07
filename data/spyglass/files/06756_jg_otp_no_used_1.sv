module unused_output_port_1 (
  input wire clk,
  input wire rst_n,
  input wire in_a,
  output wire out_b,
  output wire unused_out_c
);

  assign out_b = in_a;

  // unused_out_c is declared but never assigned or used.

endmodule
