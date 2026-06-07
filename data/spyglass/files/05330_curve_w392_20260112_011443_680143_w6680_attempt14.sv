module curve_w392_20260112_011443_680143_w6680_attempt14 (
  input wire clk,
  input wire rst_n, // Global reset signal, intended active-low
  input wire [1:0] data_in,
  output reg [1:0] q_out_low_reset,
  output reg [1:0] q_out_high_reset
);

  // Block 1: Uses rst_n as an asynchronous active-low reset
  // Sensitivity list includes negedge rst_n, and reset condition checks for !rst_n.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin // Active-low reset condition
      q_out_low_reset <= 2'b00; // Reset to 00
    end else begin
      q_out_low_reset <= data_in;
    end
  end

  // Block 2: Incorrectly uses the SAME rst_n signal as an asynchronous active-high reset.
  // Sensitivity list includes posedge rst_n, and reset condition checks for rst_n.
  // This conflicting polarity usage for rst_n across two blocks will trigger W392.
  always @(posedge clk or posedge rst_n) begin
    if (rst_n) begin // Active-high reset condition, using the signal named rst_n
      q_out_high_reset <= 2'b11; // Reset to 11
    end else begin
      q_out_high_reset <= data_in;
    end
  end

endmodule
