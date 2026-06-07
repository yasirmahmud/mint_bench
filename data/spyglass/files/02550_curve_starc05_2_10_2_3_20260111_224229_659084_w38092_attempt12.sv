module curve_starc05_2_10_2_3_20260111_224229_659084_w38092_attempt12 (
  input wire [5:0] data_operand,
  output reg       is_all_zeros
);

  // STARC05-2.10.2.3: Logical negation used on a vector '(!data_operand)'.
  // This rule fires when a logical NOT operator '!' is applied to a multi-bit vector.
  // In Verilog, '!' on a vector performs a reduction AND of all bits, then negates the result.
  // This means it evaluates to 1'b1 if all bits are 0, and 1'b0 otherwise (including if any bit is X/Z or 1).
  // This behavior can be subtle and is often a source of misinterpretation, hence the rule violation.
  always @(*) begin
    // This directly applies a logical negation to a multi-bit vector, triggering the rule.
    is_all_zeros = !data_operand;
  end

endmodule
