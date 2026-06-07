module sub_module #(
  parameter P = 0 // P is an integer type parameter (typically 32-bit signed)
) ;
  // Minimal internal content to avoid 'WarnAnalyzeBBox' for empty module definition.
  reg dummy_reg_a;
  reg [31:0] dummy_reg_b;

  // Using P in a localparam to ensure its value and type are considered in analysis.
  localparam Q = P;

  // Minimal procedural logic to ensure the module is considered 'active' and prevent other warnings.
  initial begin
    dummy_reg_a = 1'b0; // Assign a value to prevent unused signal warning for dummy_reg_a
    dummy_reg_b = Q;    // Use Q (derived from P) to prevent unused signal warning for dummy_reg_b
  end

endmodule
