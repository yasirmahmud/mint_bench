module curve_w122_20260111_144513_attempt5 (
  input wire ctrl,
  input wire [7:0] d_in,
  output reg [7:0] q_out
);

  // This is a level-sensitive always block intended to infer a D-latch.
  // The sensitivity list is intentionally incomplete, omitting 'q_out'.
  // When 'ctrl' is low, 'q_out' is updated with 'd_in' (active-low enable for update).
  // When 'ctrl' is high, 'q_out' is designed to hold its current value 
  // by assigning itself to its current value (q_out <= q_out;).
  // This explicit read of 'q_out' on the RHS, without 'q_out' being in the sensitivity list,
  // triggers SpyGlass rule W122.
  always @(ctrl or d_in) begin // 'q_out' is NOT in the sensitivity list
    if (!ctrl) begin // Active low enable for update
      q_out <= d_in;
    end else begin
      // W122 violation occurs here: 'q_out' is read on the RHS
      // but is not in the sensitivity list. This specifically triggers the W122 rule.
      q_out <= q_out; // Latch holds its current value
    end
  end

endmodule
