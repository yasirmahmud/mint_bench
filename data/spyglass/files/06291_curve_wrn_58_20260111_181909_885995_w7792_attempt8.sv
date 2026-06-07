module curve_wrn_58_20260111_181909_885995_w7792_attempt8(
  output [31:0] out_a,
  output [31:0] out_b,
  output [31:0] out_c
);

  // WRN_58: Numeric value (2147483648) exceeds 32-bit capacity
  // An unsized decimal literal '2147483648' (which is 2^31)
  // is commonly interpreted by Verilog-2001 tools as a 32-bit signed integer.
  // The maximum positive value for a 32-bit signed integer is 2^31 - 1 (2147483647).
  // Since 2147483648 exceeds this limit, it triggers WRN_58 at the literal's point of definition.

  parameter MY_OVERFLOW_PARAM_A = 2147483648; // First occurrence of WRN_58
  localparam MY_OVERFLOW_PARAM_B = 2147483648; // Second occurrence of WRN_58
  parameter MY_OVERFLOW_PARAM_C = 2147483648; // Third occurrence of WRN_58

  // Assign the parameters to output ports to ensure they are 'used' and prevent W528 warnings.
  assign out_a = MY_OVERFLOW_PARAM_A;
  assign out_b = MY_OVERFLOW_PARAM_B;
  assign out_c = MY_OVERFLOW_PARAM_C;

endmodule
