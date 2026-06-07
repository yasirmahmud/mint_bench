module sub_module #(
  parameter P = 0 // P is an integer type parameter (typically 32-bit signed)
) (
  output [31:0] dummy_output // Added an output to ensure the module is not 'empty' and uses 'P' synthesizably
);
  // Using P in a localparam to ensure its value and type are considered in analysis.
  localparam Q = P;

  // Assign Q (derived from P) to the output to prevent 'W528' unused signal warning
  // and ensure the module is considered 'active' (resolving 'WarnAnalyzeBBox').
  // The original initial block is removed, resolving 'SYNTH_5143'.
  assign dummy_output = Q;

endmodule
