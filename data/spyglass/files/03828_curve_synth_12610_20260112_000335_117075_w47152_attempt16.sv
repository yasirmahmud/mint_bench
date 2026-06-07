module curve_synth_12610_20260112_000335_117075_w47152_attempt16 (
  input wire clk,
  input wire trigger_start_in,
  input wire trigger_end_in,
  output reg dummy_out
);

  // Synthesizable logic to consume inputs and avoid W240 (unused signal) warnings.
  // This ensures 'clk', 'trigger_start_in', and 'trigger_end_in' are used outside the ignored sequence block.
  always @(posedge clk) begin
    dummy_out <= trigger_start_in & trigger_end_in;
  end

  // SYNTH_12610: Sequence blocks will be ignored for synthesis due to large delay range.
  // The delay range [1:10000] is deliberately large to trigger this warning.
  sequence large_delay_range_seq_v16;
    @(posedge clk) trigger_start_in ##[1:10000] trigger_end_in;
  endsequence

endmodule
