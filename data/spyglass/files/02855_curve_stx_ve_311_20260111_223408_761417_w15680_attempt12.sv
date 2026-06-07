module curve_stx_ve_311_20260111_223408_761417_w15680_attempt12 (
  input wire in_a,
  input wire in_b,
  output wire out
);

  reg data_reg; // This register is used on the LHS of a blocking assignment

  // STX_VE_311: Blocking assignment within expression used in continuous assignment/event expression
  // The blocking assignment `(data_reg = in_a)` is incorrectly placed
  // as an operand in the continuous assignment's bitwise XOR expression.
  assign out = (data_reg = in_a) ^ in_b;

endmodule
