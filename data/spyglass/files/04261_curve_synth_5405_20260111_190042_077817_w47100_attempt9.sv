module curve_synth_5405_20260111_190042_077817_w47100_attempt9 (
  input wire [1:0] mb_clock_in, // Multi-bit input intended as a clock
  input wire data_in,
  output reg data_out
);

  // SYNTH_5405 violation: The 'posedge' event is applied to 'mb_clock_in',
  // which is explicitly a multi-bit signal (2 bits wide). The rule requires
  // clock expressions to be one bit wide.
  always @(posedge mb_clock_in) begin
    data_out <= data_in;
  end

endmodule
