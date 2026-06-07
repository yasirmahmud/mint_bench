module curve_flopsrconst_20260112_013504_068925_w37744_attempt14 (
  input wire clk,
  input wire d,
  output reg q
);

  // Define an active-high reset signal that is constantly asserted
  wire rst = 1'b1; // This signal is always high, asserting reset

  always @(posedge clk or posedge rst) begin // Sensitive to positive edge of rst
    if (rst) begin      // If reset is active (high)
      q <= 1'b0;        // Reset the flip-flop to 0
    end else begin
      q <= d;           // This data path is never taken because rst is always high
    end
  end

endmodule
