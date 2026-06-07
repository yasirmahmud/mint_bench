module curve_synth_12610_20260111_174258_710501_w37940_attempt8 (
  input wire clk,
  input wire rst_n,
  input wire start_evt,
  input wire end_evt,
  output wire synth_dummy_out
);

  // SYNTH_12610: Sequence blocks will be ignored for synthesis due to large delay range.
  // The delay range [1:2500] is considered large by synthesis tools.
  sequence large_delay_seq_check;
    @(posedge clk) start_evt ##[1:2500] end_evt;
  endsequence

  // Use all inputs and output to prevent W240 (unused signal) warnings.
  // Note: Usage within a 'sequence' often does not prevent W240 in static analysis tools,
  // hence the explicit combinational assignment.
  assign synth_dummy_out = clk & rst_n & start_evt & end_evt;

endmodule
