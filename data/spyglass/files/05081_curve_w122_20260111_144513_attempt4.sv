module curve_w122_20260111_144513_attempt4 (
  input wire update_en,
  input wire [3:0] data_in,
  output reg [3:0] data_out
);

  // This is a level-sensitive always block designed to trigger a W122 violation.
  // The sensitivity list is intentionally incomplete, omitting 'data_out'.
  // When 'update_en' is low, 'data_out' is designed to hold its current value 
  // by assigning itself to its current value (data_out <= data_out;).
  // This read of 'data_out' on the RHS, without 'data_out' being in the sensitivity list,
  // triggers SpyGlass rule W122.
  always @(update_en or data_in) begin // 'data_out' is NOT in the sensitivity list
    if (update_en) begin
      data_out <= data_in;
    end else begin
      // W122 violation occurs here: 'data_out' is read on the RHS
      // but is not in the sensitivity list. This specifically triggers the W122 rule.
      data_out <= data_out; // Latch holds its current value
    end
  end

endmodule
