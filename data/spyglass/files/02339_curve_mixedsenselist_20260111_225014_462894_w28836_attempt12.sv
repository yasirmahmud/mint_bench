module curve_mixedsenselist_20260111_225014_462894_w28836_attempt12 (
  input clk_in,
  input level_enable,
  input input_val,
  output reg output_reg
);

  // This 'always' block is designed to trigger a 'mixedsenselist' violation.
  // The sensitivity list combines an edge-sensitive event (negedge clk_in)
  // with a level-sensitive event (level_enable). This creates an ambiguous
  // definition of hardware behavior, making it non-synthesizable.
  always @(negedge clk_in or level_enable) begin
    if (level_enable) begin
      // This branch implies a level-sensitive reset/set behavior.
      output_reg <= 1'b0;
    end else begin
      // This branch implies synchronous behavior on the clock edge.
      output_reg <= input_val;
    end
  end

endmodule
