module curve_starc05_2_3_1_6_20260111_224021_008822_w32456_attempt12 (
  input wire clk,
  input wire data_in,
  input wire reset_async_active_low,
  output reg q_out
);

  // STARC05-2.3.1.6 violation: The sensitivity list specifies a 'negedge reset_async_active_low',
  // indicating an active-low asynchronous reset. However, the reset condition 'if (reset_async_active_low)'
  // checks for an active-high logic level, which is a mismatch.
  always @(posedge clk or negedge reset_async_active_low) begin
    if (reset_async_active_low) begin // Mismatch: expecting active-low reset, but condition checks for active-high
      q_out <= 1'b1; // Reset to a known state (1'b1 for distinctness)
    end else begin
      q_out <= data_in;
    end
  end

endmodule
