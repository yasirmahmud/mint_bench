module curve_synth_12610_20260112_000335_117075_w47152_attempt15 (
  input wire clk,
  input wire start_event,
  input wire end_event,
  output reg dummy_output
);

  // Synthesizable logic to consume inputs and avoid W240 (unused signal) warnings.
  // This ensures 'clk', 'start_event', and 'end_event' are used outside the ignored sequence block.
  always @(posedge clk) begin
    dummy_output <= start_event ^ end_event;
  end

  // SYNTH_12610: Sequence blocks will be ignored for synthesis due to large delay range.
  // The delay range [1:8000] is deliberately large to trigger this warning.
  sequence s_large_delay_range_trigger;
    @(posedge clk) start_event ##[1:8000] end_event;
  endsequence

endmodule
