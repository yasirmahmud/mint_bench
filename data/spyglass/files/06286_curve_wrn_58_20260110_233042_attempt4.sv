module curve_wrn_58_20260110_233042_attempt4();

  // WRN_58: Numeric value ( 2147483648 ) exceeds 32-bit capacity
  // This value (2^31) exceeds the positive range of a signed 32-bit integer.
  parameter PARAM_VAL_1 = 2147483648;

  // WRN_58: Numeric value ( 4294967296 ) exceeds 32-bit capacity
  // This value (2^32) exceeds the maximum capacity of a 32-bit unsigned integer.
  localparam PARAM_VAL_2 = 4294967296;

  // WRN_58: Numeric value ( 2147483649 ) exceeds 32-bit capacity
  // This value (2^31 + 1) also exceeds the positive range of a signed 32-bit integer.
  parameter PARAM_VAL_3 = 2147483649;

endmodule
