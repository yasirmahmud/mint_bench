module curve_w122_20260111_144513_attempt2 (
  input wire i_enable,
  input wire i_data,
  output reg o_data
);

  // This always block describes a level-sensitive latch for 'o_data'.
  // The sensitivity list is intentionally incomplete, listing only 'i_enable' and 'i_data'.
  // When 'i_enable' is low, 'o_data' holds its value by assigning itself.
  // This read of 'o_data' on the RHS, without 'o_data' being in the sensitivity list,
  // triggers SpyGlass rule W122.
  always @(i_enable or i_data) begin
    if (i_enable) begin
      o_data <= i_data; // Latch is transparent, o_data follows i_data
    end else begin
      // W122 violation occurs here: 'o_data' is read on the RHS but is not in the sensitivity list.
      o_data <= o_data; // Latch holds its current value
    end
  end

endmodule
