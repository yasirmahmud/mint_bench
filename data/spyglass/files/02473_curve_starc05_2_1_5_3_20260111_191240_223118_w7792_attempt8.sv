module curve_starc05_2_1_5_3_20260111_191240_223118_w7792_attempt8 (
  input wire [2:0] count,      // Multi-bit input, used as condition for ternary operator
  input wire       clk,
  output reg       is_empty
);

  always @(posedge clk) begin
    // STARC05-2.1.5.3: Conditional expression 'count' does not evaluate to a scalar.
    // The ternary conditional operator (?:) expects its condition to be a single-bit scalar.
    // Here, 'count' is a multi-bit signal (3-bit), violating this expectation.
    is_empty <= count ? 1'b1 : 1'b0;
  end

endmodule
