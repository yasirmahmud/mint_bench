module curve_starc05_2_1_5_3_20260111_191240_223118_w7792_attempt7 (
  input wire [1:0] multi_bit_condition, // A multi-bit input used as a condition
  input wire       clk,
  output reg       out_signal
);

  always @(posedge clk) begin
    // STARC05-2.1.5.3: Conditional expression 'multi_bit_condition' does not evaluate to a scalar.
    // The 'if' statement expects a 1-bit scalar condition, but 'multi_bit_condition' is 2-bit.
    if (multi_bit_condition) begin
      out_signal <= 1'b1;
    end else begin
      out_signal <= 1'b0;
    end
  end

endmodule
