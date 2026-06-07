module curve_wrn_58_20260111_181909_885995_w7792_attempt6();

  // WRN_58: Numeric value (2147483648) exceeds 32-bit capacity
  // An unsized decimal literal like '2147483648' (which is 2^31)
  // is commonly interpreted by Verilog-2001 tools as a 32-bit signed integer.
  // The maximum positive value for a 32-bit signed integer is 2^31 - 1 (2147483647).
  // Since 2147483648 exceeds this limit, it triggers WRN_58 at the literal's point of definition.
  parameter MY_OVERFLOW_PARAM = 2147483648;

  // Use the parameter to avoid unused parameter warnings.
  // The WRN_58 violation is expected to occur during the evaluation of the literal itself
  // when 'MY_OVERFLOW_PARAM' is declared, prior to this assignment.
  localparam [31:0] some_reg = MY_OVERFLOW_PARAM;

endmodule
