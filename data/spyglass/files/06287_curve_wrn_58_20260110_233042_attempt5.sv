module curve_wrn_58_20260110_233042_attempt5();

  // WRN_58: Numeric value ( 2147483650 ) exceeds 32-bit capacity
  // This value (2^31 + 2) exceeds the positive range of a signed 32-bit integer.
  parameter PARAM_VAL_A = 2147483650;

  // WRN_58: Numeric value ( 4294967297 ) exceeds 32-bit capacity
  // This value (2^32 + 1) exceeds the maximum capacity of a 32-bit unsigned integer.
  parameter PARAM_VAL_B = 4294967297;

  // WRN_58: Numeric value ( 8589934592 ) exceeds 32-bit capacity
  // This value (2^33) significantly exceeds the capacity of a 32-bit integer.
  parameter PARAM_VAL_C = 8589934592;

endmodule
