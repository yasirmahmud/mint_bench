module curve_synth_12610_20260111_214707_561585_w32456_attempt11 (
  input clk,
  input start_event,
  input end_event
);

  // SYNTH_12610: Sequence blocks will be ignored for synthesis due to large delay range.
  // The delay range [1:12000] is deliberately large to trigger this warning.
  sequence my_large_delay_sequence;
    @(posedge clk) start_event ##[1:12000] end_event;
  endsequence

endmodule
