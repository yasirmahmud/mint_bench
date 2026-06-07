module unused_output_port_1 (
  input wire clk,
  input wire rst_n,
  input wire in_a,
  output wire out_b,
  output wire unused_out_c
);

  // Fix for W240: Inputs 'clk' and 'rst_n' declared but not read.
  // Assigning to dummy wires to mark them as 'used' by linter,
  // without affecting functional behavior.
  wire unused_clk = clk;
  wire unused_rst_n = rst_n;

  assign out_b = in_a;

  // Fix for "JG warning OTP_NO_USED" (implied by design description and label):
  // Output 'unused_out_c' declared but never assigned.
  // Assigning a default value to make it used and avoid floating output.
  assign unused_out_c = 1'b0;

endmodule
