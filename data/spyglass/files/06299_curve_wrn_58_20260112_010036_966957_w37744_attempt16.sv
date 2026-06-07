module curve_wrn_58_20260112_010036_966957_w37744_attempt16 (
  output [31:0] out_param_a,
  output [31:0] out_localparam_b,
  output [31:0] out_reg_c
);

  // WRN_58 (Occurrence 1):
  // The numeric literal 2147483648 exceeds the positive range of a 32-bit signed integer (2^31 - 1 = 2147483647).
  // SpyGlass will issue WRN_58 due to the implicit signed 32-bit interpretation of the literal.
  parameter OVERFLOW_VAL_A = 2147483648;

  // WRN_58 (Occurrence 2):
  // Similar to a parameter, the literal 2147483648 in a localparam declaration
  // triggers WRN_58 as it overflows the 32-bit signed integer capacity.
  localparam OVERFLOW_VAL_B = 2147483648;

  // WRN_58 (Occurrence 3):
  // When 2147483648 is assigned to a 32-bit register, the literal itself is implicitly
  // interpreted as a 32-bit signed value first, causing WRN_58, before being assigned.
  reg [31:0] internal_reg_c;
  always @(*) begin
    internal_reg_c = 2147483648;
  end

  // Connect internal values to outputs to prevent unused signal warnings (e.g., W528).
  assign out_param_a = OVERFLOW_VAL_A;
  assign out_localparam_b = OVERFLOW_VAL_B;
  assign out_reg_c = internal_reg_c;

endmodule
