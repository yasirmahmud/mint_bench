module curve_synth_12610_20260111_174258_710501_w37940_attempt7 (
  input wire clk,
  input wire rst_n,
  input wire start_signal,
  input wire end_signal,
  output wire dummy_out
);

  // SYNTH_12610: Sequence blocks will be ignored for synthesis due to large delay range.
  // The delay range [5:5000] is considered large by synthesis tools.
  sequence s_large_delay_check;
    @(posedge clk) start_signal ##[5:5000] end_signal;
  endsequence

  // To prevent W240 (unused signal) warnings, ensure all declared inputs and outputs are utilized.
  // Inputs 'clk', 'rst_n', 'start_signal', 'end_signal' and output 'dummy_out' are used here.
  // Note: Usage within a 'sequence' (e.g., 'clk', 'start_signal', 'end_signal') often does not
  // prevent W240 in static analysis tools, hence the explicit combinational assignment.
  assign dummy_out = clk & rst_n & start_signal & end_signal;

endmodule
