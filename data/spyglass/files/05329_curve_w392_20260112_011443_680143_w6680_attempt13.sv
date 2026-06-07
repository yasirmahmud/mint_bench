module curve_w392_20260112_011443_680143_w6680_attempt13 (
  input wire clk,
  input wire rst_n, // Global reset signal
  input wire data_in,
  output reg q1,
  output reg q2
);

  // Block 1: Uses rst_n as an asynchronous active-low reset
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin // Active-low reset condition
      q1 <= 1'b0;
    end else begin
      q1 <= data_in;
    end
  end

  // Block 2: Incorrectly uses the same rst_n signal as an asynchronous active-high reset
  // This conflict in polarity usage for rst_n will trigger W392.
  always @(posedge clk or posedge rst_n) begin
    if (rst_n) begin // Active-high reset condition
      q2 <= 1'b1;
    end else begin
      q2 <= data_in;
    end
  end

endmodule
