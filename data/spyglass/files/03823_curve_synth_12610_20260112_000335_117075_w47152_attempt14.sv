module curve_synth_12610_20260112_000335_117075_w47152_attempt14 (
  input wire clk,
  input wire start_event,
  input wire end_event
);

  // SYNTH_12610: Sequence blocks will be ignored for synthesis due to large delay range.
  // The delay range [0:4096] is deliberately large to trigger this warning.
  sequence s_large_delay_range;
    @(posedge clk) start_event ##[0:4096] end_event;
  endsequence

  // The input signals 'start_event' and 'end_event' are used within the sequence.
  // No other logic (like properties or always blocks) is added to ensure only
  // SYNTH_12610 is triggered and to avoid 'SYNTH_12611' or other synthesis warnings.

endmodule
