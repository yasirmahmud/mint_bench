module curve_bothedges_20260111_072157_attempt4 (
  input clk,
  input data_in,
  output out_q
);

// Internal registers for capturing data on each edge
reg out_q_pos_edge_reg;
reg out_q_neg_edge_reg;

// Register for positive edge capture
always @(posedge clk) begin
  out_q_pos_edge_reg <= data_in;
end

// Register for negative edge capture
always @(negedge clk) begin
  out_q_neg_edge_reg <= data_in;
end

// Output assignment: 'out_q' reflects the data captured on the current clock phase.
// If clk is high, 'out_q' outputs the value captured on the rising edge.
// If clk is low, 'out_q' outputs the value captured on the falling edge.
// This design maintains the functional behavior of 'out_q' updating on both clock edges,
// effectively creating a double data rate (DDR) output.
assign out_q = clk ? out_q_pos_edge_reg : out_q_neg_edge_reg;

endmodule
