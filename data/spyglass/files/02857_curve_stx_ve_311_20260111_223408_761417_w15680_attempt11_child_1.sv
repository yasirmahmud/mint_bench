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

  // Separate the continuous assignment for out_reg
  assign out_reg = in_cond ? in_a : in_b;

  // Implement the assignment to result_reg in an always block
  // The original behavior implied a level-sensitive latch:
  // result_reg is updated with in_a only when in_cond is high.
  // When in_cond is low, result_reg holds its previous value.
  always @(in_cond, in_a) begin
    if (in_cond) begin
      result_reg = in_a;
    end
    // No else branch for result_reg implicitly creates a latch
  end

endmodule
