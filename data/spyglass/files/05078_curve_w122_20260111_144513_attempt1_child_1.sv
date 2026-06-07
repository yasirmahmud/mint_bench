module curve_w122_20260111_144513_attempt1 (
  input wire enable,
  output reg data_out
);

  reg in0; // The signal that was causing the W122 violation

  // This block implements a latch. When 'enable' is low, 'in0' retains its previous value.
  // By removing the explicit 'in0 <= in0;' for the hold state, we resolve:
  // 1. W122: 'in0' is no longer read on the RHS inside the always block, thus not needing to be in the sensitivity list for its own value.
  // 2. CombLoop: The explicit self-assignment that created a combinatorial loop interpretation is removed.
  // The functional behavior of a latch is preserved through inference.
  always @(enable) begin // Sensitivity list is now complete for this latch inference style.
    if (enable) begin
      in0 <= 1'b0; // Assign a constant value when enabled.
    end
    // else: 'in0' retains its previous value, inferring a latch.
  end

  assign data_out = in0;

endmodule
