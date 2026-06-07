module curve_synth_5317_20260110_182155_attempt6 (
  input clk,
  input data_in,
  output reg data_out
);

  always @(data_in) begin
    // SYNTH_5317 violation: The always block has an event list, and
    // an assignment within it includes an embedded event control in the RHS.
    data_out = @(posedge clk) data_in;
  end

endmodule
