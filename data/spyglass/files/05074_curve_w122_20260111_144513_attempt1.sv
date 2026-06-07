module curve_w122_20260111_144513_attempt1 (
  input wire enable,
  output reg data_out
);

  reg in0; // The signal that will trigger the W122 violation

  // This block implements a latch with an explicit hold state.
  // The sensitivity list is incomplete, as 'in0' itself is read on line 13
  // but is not part of the sensitivity list.
  always @(enable) begin // Sensitivity list explicitly misses 'in0'
    if (enable) begin
      in0 <= 1'b0; // Assign a constant value; no other inputs are needed for this path.
    end else begin
      // This line reads 'in0' on the RHS ('in0' current value) to explicitly hold its state.
      // Since 'in0' is read but not in the sensitivity list, SpyGlass W122 is expected here.
      in0 <= in0;
    end
  end

  assign data_out = in0;

endmodule
