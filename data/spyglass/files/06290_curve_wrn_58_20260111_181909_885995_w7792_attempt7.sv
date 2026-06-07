module curve_wrn_58_20260111_181909_885995_w7792_attempt7();

  // WRN_58: Numeric value (2147483648) exceeds 32-bit capacity
  // An unsized decimal literal '2147483648' (which is 2^31)
  // is commonly interpreted by Verilog-2001 tools as a 32-bit signed integer.
  // The maximum positive value for a 32-bit signed integer is 2^31 - 1 (2147483647).
  // Since 2147483648 exceeds this limit, it triggers WRN_58 at the literal's point of definition.

  parameter MY_OVERFLOW_PARAM_A = 2147483648; // First occurrence of WRN_58
  localparam MY_OVERFLOW_PARAM_B = 2147483648; // Second occurrence of WRN_58
  parameter MY_OVERFLOW_PARAM_C = 2147483648; // Third occurrence of WRN_58

  // Use the parameters to avoid unused parameter warnings.
  // The WRN_58 violations are expected to occur during the evaluation of the literal values
  // themselves when these parameters are declared, prior to their use below.
  wire [31:0] dummy_a;
  wire [31:0] dummy_b;
  wire [31:0] dummy_c;

  assign dummy_a = MY_OVERFLOW_PARAM_A;
  assign dummy_b = MY_OVERFLOW_PARAM_B;
  assign dummy_c = MY_OVERFLOW_PARAM_C;

endmodule
