module curve_synth_12610_20260111_174258_710501_w37940_attempt6 (
  input wire clk,
  input wire rst_n,
  input wire start_signal,
  input wire end_signal,
  output wire dummy_out
);

  // SYNTH_12610: Sequence blocks will be ignored for synthesis due to large delay range.
  // The delay range [1:2500] is considered large.
  sequence s_long_delay;
    @(posedge clk) start_signal ##[1:2500] end_signal;
  endsequence

  // Prevent unused signal warnings for inputs and output
  assign dummy_out = start_signal & end_signal & rst_n;

endmodule
