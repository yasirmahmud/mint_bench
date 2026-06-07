module curve_w122_20260111_144513_attempt5 (
  input wire ctrl,
  input wire [7:0] d_in,
  output reg [7:0] q_out
);

  // This is a level-sensitive always block intended to infer a D-latch.
  // The sensitivity list is intentionally incomplete, omitting 'q_out'.
  // When 'ctrl' is low, 'q_out' is updated with 'd_in' (active-low enable for update).
  // When 'ctrl' is high, 'q_out' is designed to hold its current value.
  // To resolve W122, the explicit self-assignment (q_out <= q_out;) is removed.
  // In Verilog, an unassigned 'reg' in an always block implies a hold, inferring a latch.
  always @(ctrl or d_in) begin
    if (!ctrl) begin // Active low enable for update
      q_out <= d_in;
    end
    // When 'ctrl' is high, 'q_out' is not explicitly assigned within the block.
    // This implicitly infers a latch, causing 'q_out' to hold its current value,
    // thereby maintaining the original functional behavior without reading 'q_out'
    // on the RHS, which resolves the W122 violation.
  end

endmodule
