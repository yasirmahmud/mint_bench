module sub_module #(
  parameter P = 1'b0 // P is explicitly defined as a 1-bit scalar parameter
) (
  input clk // Added to prevent 'WarnAnalyzeBBox' for empty module
);
  // No internal logic is required to trigger the parameter connection violation.
endmodule
