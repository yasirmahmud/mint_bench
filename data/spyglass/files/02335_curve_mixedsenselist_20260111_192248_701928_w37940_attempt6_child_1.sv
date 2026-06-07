module curve_mixedsenselist_20260111_192248_701928_w37940_attempt6 (
  input clk,
  input data_in,
  output reg data_out
);

  // To resolve the 'mixedsenselist' violation and correctly infer a level-sensitive latch,
  // the sensitivity list must only contain level-sensitive signals (clk and data_in).
  // 'data_out' follows 'data_in' when 'clk' is low, and holds its value when 'clk' is high.
  always @(clk or data_in) begin
    if (~clk) begin // When clk is low, the latch is transparent
      data_out <= data_in;
    end
    // When clk is high, data_out holds its value, inferring a latch.
  end

endmodule
