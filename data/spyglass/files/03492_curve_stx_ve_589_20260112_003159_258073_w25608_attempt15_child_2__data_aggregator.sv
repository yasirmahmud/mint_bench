// Verilog-2001 example for STX_VE_589
// This rule flags multiple module declarations with the same name within the same file.
// To trigger two STX_VE_589 violations, we define the module 'data_aggregator' three times.

// First declaration of 'data_aggregator'.
// This serves as the initial definition and will be referenced by subsequent violations.
module data_aggregator (
  input wire clk,
  input wire rst_ni,
  input wire enable_i
);

  // Removed 'unused_sig_1' to resolve W528 violation, as it was set but not read.

endmodule
