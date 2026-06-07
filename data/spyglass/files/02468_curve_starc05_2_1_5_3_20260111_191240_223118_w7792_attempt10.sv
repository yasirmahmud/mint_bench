module curve_starc05_2_1_5_3_20260111_191240_223118_w7792_attempt10 (
  input wire [1:0] data_in,
  output reg flag_out
);

  // STARC05-2.1.5.3: Conditional expression (data_in) does not evaluate to a scalar.
  // This rule is triggered when the first operand of a conditional (ternary) operator
  // is a multi-bit expression. SpyGlass expects this expression to be scalar (1-bit).
  // Here, 'data_in' is explicitly declared as a 2-bit wide signal, violating the rule
  // when used as the condition for the ternary operator.
  always @(*) begin
    flag_out = data_in ? 1'b1 : 1'b0;
  end

endmodule
