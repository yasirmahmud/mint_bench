module curve_mixedsenselist_20260111_081304_attempt1 (
    input clk,
    input data_in,
    output reg data_out
);

  // This always block violates 'mixedsenselist' because its sensitivity list
  // contains both an edge-triggered event (posedge clk) and a level-sensitive event (data_in).
  // Synthesis tools cannot reconcile these mixed types into a single hardware element
  // (e.g., a simple flip-flop or a purely combinational block).
  always @(posedge clk or data_in) begin
    data_out <= data_in;
  end

endmodule
