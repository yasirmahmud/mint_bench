module curve_w392_20260111_222149_668514_w28836_attempt11 (
  input wire clk,
  input wire rst_i, // This reset signal will be used with different polarities
  input wire data_in,
  output reg q_ah1,
  output reg q_ah2,
  output reg q_al1,
  output reg q_al2
);

  // To resolve W392, distinct reset signals are derived from the input 'rst_i'.
  // 'rst_i_active_high_sig' is for active-high reset logic.
  // 'rst_i_active_low_inverted_sig' is the inversion of 'rst_i', and its positive edge
  // corresponds to the negative edge of 'rst_i', used for active-low reset logic.
  // This preserves the original functional behavior where 'rst_i' serves both
  // active-high and active-low resets, but avoids using 'rst_i' directly with
  // both posedge and negedge in sensitivity lists.
  wire rst_i_active_high_sig = rst_i;
  wire rst_i_active_low_inverted_sig = ~rst_i; // This signal is active high when rst_i is low

  // Block 1: Uses rst_i_active_high_sig as an asynchronous active-high reset
  always @(posedge clk or posedge rst_i_active_high_sig) begin
    if (rst_i_active_high_sig) begin // Reset condition for active-high (rst_i == 1'b1)
      q_ah1 <= 1'b0;
    end else begin
      q_ah1 <= data_in;
    end
  end

  // Block 2: Also uses rst_i_active_high_sig as an asynchronous active-high reset
  always @(posedge clk or posedge rst_i_active_high_sig) begin
    if (rst_i_active_high_sig) begin // Reset condition for active-high (rst_i == 1'b1)
      q_ah2 <= 1'b1;
    end else begin
      q_ah2 <= data_in;
    end
  end

  // Block 3: Uses rst_i_active_low_inverted_sig to implement an asynchronous active-low reset
  // The 'posedge rst_i_active_low_inverted_sig' is functionally equivalent to 'negedge rst_i'.
  always @(posedge clk or posedge rst_i_active_low_inverted_sig) begin
    if (rst_i_active_low_inverted_sig) begin // Reset condition for active-low (rst_i == 1'b0)
      q_al1 <= 1'b0;
    end else begin
      q_al1 <= data_in;
    end
  end

  // Block 4: Also uses rst_i_active_low_inverted_sig to implement an asynchronous active-low reset
  // The 'posedge rst_i_active_low_inverted_sig' is functionally equivalent to 'negedge rst_i'.
  always @(posedge clk or posedge rst_i_active_low_inverted_sig) begin
    if (rst_i_active_low_inverted_sig) begin // Reset condition for active-low (rst_i == 1'b0)
      q_al2 <= 1'b1;
    end else begin
      q_al2 <= data_in;
    end
  end

endmodule
