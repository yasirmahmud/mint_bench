module curve_synth_5378_w32456 (
  input clk_a,
  input clk_b,
  input data_in,
  output reg data_out
);

  // SYNTH_5378: Complex expression 'posedge (clk_a ^ clk_b)' is not allowed
  // in event specification for synthesis. Synthesis tools typically require
  // a simple signal name for clock/reset events.
  always @(posedge (clk_a ^ clk_b)) begin
    data_out <= data_in;
  end

endmodule
