module curve_w122_20260111_144513_attempt2 (
  input wire i_enable,
  input wire i_data,
  output reg o_data
);

  // This always block describes a level-sensitive latch for 'o_data'.
  // The sensitivity list is now complete to resolve the W122 violation.
  // When 'i_enable' is low, 'o_data' holds its value by assigning itself.
  // By including 'o_data' in the sensitivity list, the W122 violation is resolved.
  always @(i_enable or i_data or o_data) begin
    if (i_enable) begin
      o_data <= i_data; // Latch is transparent, o_data follows i_data
    end else begin
      // W122 violation is resolved as 'o_data' is now in the sensitivity list.
      o_data <= o_data; // Latch holds its current value
    end
  end

endmodule
