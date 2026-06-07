module curve_synth_5405_20260111_190042_077817_w47100_attempt10 (
  input wire bit_a,
  input wire bit_b,
  input wire data_in,
  output reg data_out
);

  // SYNTH_5405 violation: The 'posedge' event is applied to an expression
  // whose width can be greater than one bit.
  // In Verilog-2001, the sum of two 1-bit operands (bit_a + bit_b)
  // can result in a 2-bit value (e.g., 1'b1 + 1'b1 = 2'b10).
  // This makes the clock expression multi-bit wide, violating SYNTH_5405.
  always @(posedge (bit_a + bit_b)) begin
    data_out <= data_in;
  end

endmodule
