module curve_starc05_2_10_3_2a_20260111_033754_attempt2 (
  input [0:0] control_enable,
  output out_status
);

  // STARC05-2.10.3.2a: Operand bit-width mismatch for operator '&&'.
  // 'control_enable' is 1-bit, '5'd13' is 5-bit.
  // This should trigger the target rule.
  //
  // To avoid STARC05-2.1.4.5 (use bit-wise '&' instead of logical '&&'):
  // The second operand '5'd13' is a constant. Its logical value is 1'b1.
  // The expression 'control_enable && 5'd13' is functionally equivalent to 'control_enable && 1'b1',
  // which effectively operates on two 1-bit values. This context might prevent
  // SpyGlass from suggesting a bit-wise '&' (STARC05-2.1.4.5) because the intent
  // is clearly logical, and the multi-bit operand is a constant whose logical
  // reduction is trivial.
  assign out_status = control_enable && 5'd13;

endmodule
