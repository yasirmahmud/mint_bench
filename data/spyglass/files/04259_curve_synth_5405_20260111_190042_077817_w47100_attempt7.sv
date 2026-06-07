module curve_synth_5405_20260111_190042_077817_w47100_attempt7 (
  input [7:0] data_in,
  input [2:0] multi_bit_clk, // This is intentionally multi-bit
  output reg [7:0] data_out
);

  // SYNTH_5405 violation: Clock expression 'multi_bit_clk' must be one bit wide.
  always @(posedge multi_bit_clk) begin
    data_out <= data_in;
  end

endmodule
