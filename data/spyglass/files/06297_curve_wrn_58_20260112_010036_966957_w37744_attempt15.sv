module curve_wrn_58_20260112_010036_966957_w37744_attempt15 (
  output [31:0] out_param_val,
  output [31:0] out_localparam_val,
  output [31:0] out_assign_val
);

  // WRN_58 (Occurrence 1):
  // The numeric value 2147483648 exceeds the positive capacity of a 32-bit signed integer (2^31 - 1 = 2147483647).
  // SpyGlass will issue WRN_58 at this literal definition point for the implicit 32-bit signed interpretation.
  parameter PARAM_OVERFLOW_A = 2147483648;

  // WRN_58 (Occurrence 2):
  // Similarly, for a localparam, the literal 2147483648 is implicitly interpreted
  // as a signed 32-bit value, triggering WRN_58.
  localparam LOCALPARAM_OVERFLOW_B = 2147483648;

  // WRN_58 (Occurrence 3):
  // Assigning the overflow value directly to a 32-bit wide wire.
  // The literal 2147483648 is implicitly interpreted as a signed 32-bit value during assignment, triggering WRN_58.
  wire [31:0] internal_assign_wire;
  assign internal_assign_wire = 2147483648;

  // Connect internal values to outputs to prevent unused signal warnings (e.g., W528).
  assign out_param_val = PARAM_OVERFLOW_A;
  assign out_localparam_val = LOCALPARAM_OVERFLOW_B;
  assign out_assign_val = internal_assign_wire;

endmodule
