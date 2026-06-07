module curve_synth_5317_20260110_182155_attempt8 (
  input clk,
  input data_in,
  input trigger_sig,
  output reg data_out
);

  // SYNTH_5317 violation: The always block has an event control (@trigger_sig)
  // and an assignment within it includes an embedded event control (@(posedge clk)) in the RHS.
  always @(trigger_sig) begin
    data_out = @(posedge clk) data_in;
  end

endmodule
