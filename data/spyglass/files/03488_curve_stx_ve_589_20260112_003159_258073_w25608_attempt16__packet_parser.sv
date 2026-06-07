// Verilog-2001 example for STX_VE_589
// This rule flags multiple module declarations with the same name within the same file.
// To trigger exactly two STX_VE_589 violations, we define the module 'packet_parser' three times.

// First declaration of 'packet_parser'.
// This serves as the initial definition and will be referenced by subsequent violations.
module packet_parser (
  input wire clk_i,
  input wire rst_n_i,
  output wire busy_o
);

  // Simple logic to avoid unused signal warnings
  assign busy_o = clk_i & rst_n_i;

endmodule
