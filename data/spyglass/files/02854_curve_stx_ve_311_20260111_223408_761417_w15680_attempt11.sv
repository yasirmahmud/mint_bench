module curve_stx_ve_311_20260111_223408_761417_w15680_attempt11 (
  input wire      in_a,
  input wire      in_b,
  input wire      in_cond,
  output wire     out_reg
);

  reg result_reg; // This register is used on the LHS of a blocking assignment

  // STX_VE_311: Blocking assignment within expression used in continuous assignment
  // The blocking assignment `(result_reg = in_a)` is incorrectly placed
  // as an operand in the continuous assignment's ternary expression.
  assign out_reg = in_cond ? (result_reg = in_a) : in_b;

endmodule
