module curve_mixedsenselist_20260111_192248_701928_w37940_attempt6 (
  input clk,
  input data_in,
  output reg data_out
);

  // This always block triggers a 'mixedsenselist' violation because its sensitivity list
  // contains both an edge-sensitive condition (negedge clk) and a level-sensitive condition (data_in).
  // Mixing these types of conditions is considered non-synthesizable by some tools or leads to ambiguous behavior.
  always @(negedge clk or data_in) begin
    if (~clk) begin // When clk is low, the latch is transparent
      data_out <= data_in;
    end
    // When clk is high, data_out holds its value. This structure typically infers a latch.
    // The 'mixedsenselist' violation is specifically due to the sensitivity list itself.
  end

endmodule
