// Submodule declaration with an integer parameter
module CHILD_PROCESSOR (
  input wire clk_in,
  output wire proc_out
);
  parameter CLOCK_DIVISOR = 10; // An integer parameter to be overridden

  // Use the parameter in a minimal way to avoid unused signal warnings
  // For simplicity, we just use it in a conditional assignment.
  assign proc_out = (CLOCK_DIVISOR > 5) ? clk_in : ~clk_in; 

endmodule
