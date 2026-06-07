module curve_starc05_2_1_5_3_20260111_224808_647010_w49296_attempt12 (
  input wire [1:0] data_in,
  input wire       control,
  output reg       out_reg
);

  // STARC05-2.1.5.3: Conditional expression 'data_in' does not evaluate to a scalar.
  // The ternary conditional operator (?:) expects its condition to be a single-bit scalar,
  // but 'data_in' is a 2-bit signal, thus violating the rule.
  always @(*) begin
    out_reg = data_in ? control : 1'b0;
  end

endmodule
