module curve_starc05_2_1_5_3_20260111_191240_223118_w7792_attempt6 (
  input wire [7:0] data_in_multi, // Multi-bit input to trigger the rule
  output reg       enable_scalar
);

  always @(*) begin
    // STARC05-2.1.5.3: Conditional expression 'data_in_multi' is multi-bit, not scalar.
    // SpyGlass expects the condition of a ternary operator to be a scalar (1-bit).
    enable_scalar = data_in_multi ? 1'b1 : 1'b0;
  end

endmodule
