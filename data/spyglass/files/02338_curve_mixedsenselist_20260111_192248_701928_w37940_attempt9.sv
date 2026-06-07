module curve_mixedsenselist_20260111_192248_701928_w37940_attempt9 (
  input clk,
  input data_in,
  output reg data_out
);

  // This always block triggers a 'mixedsenselist' violation.
  // The sensitivity list explicitly mixes an edge-sensitive condition ('posedge clk')
  // with a level-sensitive condition ('data_in').
  // This combination creates an ambiguous description for synthesis tools,
  // as it implies both sequential and combinatorial behavior for 'data_out'
  // within the same always block, leading to the reported violation.
  always @(posedge clk or data_in) begin
    // The intention here is confused by the mixed sensitivity list.
    // If 'data_in' changes, 'data_out' would update (level-sensitive).
    // If 'posedge clk' occurs, 'data_out' would also update (edge-sensitive).
    // This ambiguity is the root cause of the 'mixedsenselist' rule.
    if (data_in) begin
      data_out <= 1'b1;
    end else begin
      data_out <= 1'b0;
    end
  end

endmodule
