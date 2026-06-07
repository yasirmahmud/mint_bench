module curve_w392_20260112_011443_680143_w6680_attempt15 (
  input wire clk,
  input wire reset_main, // Primary reset signal, intended for conflicting polarities
  input wire [3:0] data_in,
  output reg [3:0] q_active_low_rst,
  output reg [3:0] q_active_high_rst
);

  // First block: Uses reset_main as an asynchronous active-low reset.
  // The sensitivity list includes negedge reset_main, and the reset condition checks for !reset_main.
  always @(posedge clk or negedge reset_main) begin
    if (!reset_main) begin // Active-low reset condition
      q_active_low_rst <= 4'h0; // Reset to all zeros
    end else begin
      q_active_low_rst <= data_in;
    end // Fixed: Changed '_end' to 'end' to resolve STX_VE_573
  end

  // Second block: Uses the SAME reset_main signal as an asynchronous active-high reset.
  // The sensitivity list includes posedge reset_main, and the reset condition checks for reset_main.
  // This conflicting polarity usage for reset_main across these two blocks will trigger W392.
  always @(posedge clk or posedge reset_main) begin
    if (reset_main) begin // Active-high reset condition
      q_active_high_rst <= 4'hF; // Reset to all ones
    end else begin
      q_active_high_rst <= data_in;
    end
  end

endmodule
