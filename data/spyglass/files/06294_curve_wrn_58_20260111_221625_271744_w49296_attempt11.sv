module curve_wrn_58_20260111_221625_271744_w49296_attempt11 (
  input wire en,
  output wire [31:0] out_param_val,
  output wire [31:0] out_wire_val,
  output wire [31:0] out_reg_val
);

  // WRN_58 (Occurrence 1):
  // The unsized decimal literal 2147483648 (which is 2^31) is implicitly treated
  // as a 32-bit signed integer by Verilog-2001. This value exceeds the maximum
  // positive capacity for a 32-bit signed integer (2^31 - 1 or 2147483647),
  // triggering WRN_58.
  parameter PARAM_OVERFLOW_VAL = 2147483648;

  // WRN_58 (Occurrence 2):
  // Similar to the parameter, the direct use of the literal 2147483648 in an
  // assignment to a 32-bit wire triggers WRN_58 due to its implicit 32-bit
  // signed interpretation exceeding its positive range.
  wire [31:0] intermediate_wire;
  assign intermediate_wire = 2147483648;

  // WRN_58 (Occurrence 3):
  // The literal 2147483648 used in an assignment within an always block
  // to a 32-bit register also causes WRN_58 for the same reason:
  // exceeding 32-bit signed capacity.
  reg [31:0] internal_register;
  always @(*) begin
    internal_register = 2147483648;
  end

  // Use all declared items to prevent unused warnings (e.g., W528)
  assign out_param_val = PARAM_OVERFLOW_VAL + (en ? 32'd1 : 32'd0);
  assign out_wire_val = intermediate_wire;
  assign out_reg_val = internal_register;

endmodule
