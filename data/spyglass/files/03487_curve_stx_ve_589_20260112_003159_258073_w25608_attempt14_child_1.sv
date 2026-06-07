// Verilog-2001 example for STX_VE_589
// This rule flags multiple module declarations with the same name within the same scope.
// The original design had 'fifo_controller' declared three times, causing two STX_VE_589 violations.
// To resolve this, all declarations have been merged into a single module.

// Combined declaration of 'fifo_controller'.
module fifo_controller (
  input wire clk,
  input wire rst_ni,
  input wire write_en,
  input wire read_en,
  output wire [7:0] data_out,
  output wire almost_full,
  output wire almost_empty
);

  // Simple combinational logic from the first declaration to avoid unused signal warnings
  wire unused_sig_1 = clk & rst_ni & write_en;

  // Logic from the second declaration
  assign data_out = read_en ? 8'hAA : 8'h00;

  // Logic from the third declaration
  assign almost_full = 1'b0;
  assign almost_empty = 1'b1;

endmodule
