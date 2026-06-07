module curve_flopsrconst_20260112_013504_068925_w37744_attempt13 (
  input wire clk,
  input wire d,
  output reg q
);

  // Define an active-low reset signal that is constantly asserted
  wire rst_n = 1'b0; // This signal is always low, asserting reset

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin   // If reset is active (low)
      q <= 1'b0;        // Reset the flip-flop
    end else begin
      q <= d;           // This data path is never taken
    end
  end

endmodule
