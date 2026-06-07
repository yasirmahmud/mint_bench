// Verilog-2001 example for STX_VE_589
// This rule flags multiple module declarations with the same name within the same scope.
// We need to declare the module 'fifo_controller' three times to get two violations.

// First declaration of 'fifo_controller'.
// This serves as the initial definition and will be referenced by subsequent violations.
module fifo_controller (
  input wire clk,
  input wire rst_ni,
  input wire write_en
);

  // Simple combinational logic to avoid unused signal warnings
  wire unused_sig_1 = clk & rst_ni & write_en;

endmodule
