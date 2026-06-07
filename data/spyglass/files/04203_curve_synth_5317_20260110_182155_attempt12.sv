module curve_synth_5317_20260110_182155_attempt12 (
  input clk,
  input data_in,
  input enable_in,
  output reg data_out
);

  // SYNTH_5317 violation: The always block's sensitivity list (@enable_in)
  // acts as a timing control statement, and the assignment within it includes
  // an embedded event control (@(posedge clk)) on the RHS. This combination
  // is not supported by synthesis.
  always @(enable_in) begin
    data_out = @(posedge clk) data_in; // Embedded event control in RHS
  end

endmodule
