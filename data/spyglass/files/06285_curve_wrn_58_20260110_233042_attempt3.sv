module curve_wrn_58_20260110_233042_attempt3();

  // WRN_58: Numeric value ( 2147483648 ) exceeds 32-bit capacity
  // This value (2^31) exceeds the positive range of a signed 32-bit integer.
  // Using this specific value directly triggers WRN_58 for exceeding 32-bit capacity.
  parameter OVERFLOW_PARAM = 2147483648;

endmodule
