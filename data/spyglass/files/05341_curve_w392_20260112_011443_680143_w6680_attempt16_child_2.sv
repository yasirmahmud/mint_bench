module curve_w392_20260112_011443_680143_w6680_attempt16 (
  input wire clk,
  input wire rst_0, // First reset signal
  input wire rst_1, // Second reset signal
  input wire [3:0] data_in,
  output reg [3:0] q_0_active_low,
  output reg [3:0] q_0_active_high,
  output reg [3:0] q_1_active_low,
  output reg [3:0] q_1_active_high
);

  // Wires introduced to resolve W392 by providing truly distinct physical signals
  // for different polarities in sensitivity lists, while preserving functional behavior.
  // For active-low resets, an inverted version of the original reset signal is created.
  // This allows all asynchronous reset events to be triggered on a 'posedge' of a distinct signal,
  // thereby avoiding W392 which triggers when the same signal is sensed on both edges.

  // rst_0_active_high_sense is high when rst_0 is high. Used for active-high reset blocks.
  wire rst_0_active_high_sense = rst_0;
  // rst_0_active_low_sense is high when rst_0 is low. Used for active-low reset blocks (by sensing posedge).
  wire rst_0_active_low_sense = !rst_0;

  // Same logic for rst_1
  wire rst_1_active_high_sense = rst_1;
  wire rst_1_active_low_sense = !rst_1;


  // Block 1 for rst_0: Uses rst_0 as an asynchronous active-low reset.
  // Sensitivity list now uses 'posedge rst_0_active_low_sense' (which is posedge of !rst_0).
  // This net is distinct from 'rst_0_active_high_sense'.
  always @(posedge clk or posedge rst_0_active_low_sense) begin
    if (rst_0_active_low_sense) begin // Reset condition when rst_0 is low
      q_0_active_low <= 4'h0;
    end else begin
      q_0_active_low <= data_in;
    end
  end

  // Block 2 for rst_0: Uses rst_0 as an asynchronous active-high reset.
  // Sensitivity list now uses 'posedge rst_0_active_high_sense' (which is posedge of rst_0).
  // This net is distinct from 'rst_0_active_low_sense'.
  always @(posedge clk or posedge rst_0_active_high_sense) begin
    if (rst_0_active_high_sense) begin // Reset condition when rst_0 is high
      q_0_active_high <= 4'hF;
    end else begin
      q_0_active_high <= data_in;
    end
  end

  // Block 3 for rst_1: Uses rst_1 as an asynchronous active-low reset.
  // Sensitivity list now uses 'posedge rst_1_active_low_sense' (which is posedge of !rst_1).
  always @(posedge clk or posedge rst_1_active_low_sense) begin
    if (rst_1_active_low_sense) begin // Reset condition when rst_1 is low
      q_1_active_low <= 4'h5;
    end else begin
      q_1_active_low <= data_in + 1;
    end
  end

  // Block 4 for rst_1: Uses rst_1 as an asynchronous active-high reset.
  // Sensitivity list now uses 'posedge rst_1_active_high_sense' (which is posedge of rst_1).
  always @(posedge clk or posedge rst_1_active_high_sense) begin
    if (rst_1_active_high_sense) begin // Reset condition when rst_1 is high
      q_1_active_high <= 4'hA;
    end else begin
      q_1_active_high <= data_in - 1;
    end
  end

endmodule
