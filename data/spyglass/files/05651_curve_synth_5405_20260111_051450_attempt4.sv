module curve_synth_5405_20260111_051450_attempt4 (
  input [1:0] multi_bit_clk, // Multi-bit signal intended as a clock
  input data_in,
  output reg data_out
);

  // SYNTH_5405: Clock expression 'multi_bit_clk' must be one bit wide
  // This rule is triggered because 'multi_bit_clk' is a 2-bit signal
  // used directly in a 'posedge' sensitivity list, which is interpreted
  // as a multi-bit clock expression.
  always @(posedge multi_bit_clk) begin
    data_out <= data_in;
  end

endmodule
