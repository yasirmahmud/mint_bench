module curve_synth_5317_20260110_182155_attempt9 (
  input clk,
  input data_in,
  output reg data_out
);

  // SYNTH_5317 violation: The always block has a sensitivity list (`@data_in`)
  // and an assignment within it includes an embedded event control (`@(posedge clk)`) in the RHS.
  always @(data_in) begin
    data_out = @(posedge clk) data_in;
  end

endmodule
