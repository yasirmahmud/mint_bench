module curve_w122_20260111_144513_attempt2 (
  input wire i_enable,
  input wire i_data,
  output reg o_data
);

  // This always block describes a level-sensitive latch for 'o_data'.
  // The sensitivity list includes 'o_data' to resolve the W122 violation, as per the original design intent.
  // When 'i_enable' is low, 'o_data' holds its value implicitly by not being assigned.
  // The explicit self-assignment 'o_data <= o_data;' has been removed to resolve the W502 violation,
  // while preserving the functional behavior of the latch.
  always @(i_enable or i_data or o_data) begin
    if (i_enable) begin
      o_data <= i_data; // Latch is transparent, o_data follows i_data
    end
    // When i_enable is low, no assignment occurs, causing o_data to retain its value.
    // This implicitly describes the hold behavior of the latch and resolves the W502
    // that was associated with the explicit 'o_data <= o_data;' assignment.
  end

endmodule
