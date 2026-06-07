module curve_synth_5317_20260110_182155_attempt13 (
  input clk,
  input data_in,
  output reg data_out
);

  // SYNTH_5317 violation: This always block has a timing control statement (@(*))
  // and an embedded event control (@(posedge clk)) on the Right-Hand Side (RHS)
  // of an assignment, which is not supported by synthesis.
  always @(*) begin
    data_out = @(posedge clk) data_in; // Embedded event control on RHS
  end

endmodule
