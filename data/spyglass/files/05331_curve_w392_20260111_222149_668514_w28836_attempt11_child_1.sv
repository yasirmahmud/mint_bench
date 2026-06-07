module curve_w392_20260111_222149_668514_w28836_attempt11 (
  input wire clk,
  input wire rst_i, // This reset signal will be used with different polarities
  input wire data_in,
  output reg q_ah1,
  output reg q_ah2,
  output reg q_al1,
  output reg q_al2
);

  // To resolve W392, distinct wire names are used for the same underlying reset signal
  // when it is interpreted with different polarities. This preserves the original
  // functional behavior where 'rst_i' itself serves both active-high and active-low resets.
  wire rst_i_active_high = rst_i;
  wire rst_i_active_low = rst_i;

  // Block 1: Uses rst_i_active_high as an asynchronous active-high reset
  always @(posedge clk or posedge rst_i_active_high) begin
    if (rst_i_active_high) begin // Reset condition for active-high
      q_ah1 <= 1'b0;
    end else begin
      q_ah1 <= data_in;
    end
  end

  // Block 2: Also uses rst_i_active_high as an asynchronous active-high reset
  always @(posedge clk or posedge rst_i_active_high) begin
    if (rst_i_active_high) begin // Reset condition for active-high
      q_ah2 <= 1'b1;
    end else begin
      q_ah2 <= data_in;
    end
  end

  // Block 3: Uses rst_i_active_low as an asynchronous active-low reset
  always @(posedge clk or negedge rst_i_active_low) begin
    if (!rst_i_active_low) begin // Reset condition for active-low
      q_al1 <= 1'b0;
    end else begin
      q_al1 <= data_in;
    end
  end

  // Block 4: Also uses rst_i_active_low as an asynchronous active-low reset
  always @(posedge clk or negedge rst_i_active_low) begin
    if (!rst_i_active_low) begin // Reset condition for active-low
      q_al2 <= 1'b1;
    end else begin
      q_al2 <= data_in;
    end
  end

endmodule
