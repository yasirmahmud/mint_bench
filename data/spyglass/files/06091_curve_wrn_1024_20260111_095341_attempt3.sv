module curve_wrn_1024_20260111_095341_attempt3 (
  input wire signed [15:0] operand_a,
  input wire [15:0] operand_b,
  output wire signed [16:0] result
);

  // WRN_1024: signed argument 'operand_a' passed to $signed system function call
  assign result = $signed(operand_a) + $signed(operand_b);

endmodule
