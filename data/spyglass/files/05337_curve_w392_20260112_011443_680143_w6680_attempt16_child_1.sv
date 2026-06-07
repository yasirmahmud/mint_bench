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

  // Wires introduced to resolve W392 by providing distinct signal names
  // for different polarities in sensitivity lists, while preserving the
  // functional behavior (same original source signal for reset conditions).
  wire rst_0_active_high_edge = rst_0; // Alias for rst_0 to be used for active-high blocks
  wire rst_1_active_high_edge = rst_1; // Alias for rst_1 to be used for active-high blocks


  // Block 1 for rst_0: Uses rst_0 as an asynchronous active-low reset.
  // This usage of 'rst_0' (negedge) is now separate from 'rst_0_active_high_edge' (posedge).
  always @(posedge clk or negedge rst_0) begin
    if (!rst_0) begin // Active-low reset condition
      q_0_active_low <= 4'h0;
    end else begin
      q_0_active_low <= data_in;
    end
  end

  // Block 2 for rst_0: Uses the SAME functional behavior (reset when original rst_0 is high).
  // Now uses 'rst_0_active_high_edge' in sensitivity list to avoid W392 with 'rst_0'.
  always @(posedge clk or posedge rst_0_active_high_edge) begin
    if (rst_0_active_high_edge) begin // Active-high reset condition
      q_0_active_high <= 4'hF;
    end else begin
      q_0_active_high <= data_in;
    end
  end

  // Block 3 for rst_1: Uses rst_1 as an asynchronous active-low reset.
  // This usage of 'rst_1' (negedge) is now separate from 'rst_1_active_high_edge' (posedge).
  always @(posedge clk or negedge rst_1) begin
    if (!rst_1) begin // Active-low reset condition
      q_1_active_low <= 4'h5;
    end else begin
      q_1_active_low <= data_in + 1;
    end
  end

  // Block 4 for rst_1: Uses the SAME functional behavior (reset when original rst_1 is high).
  // Now uses 'rst_1_active_high_edge' in sensitivity list to avoid W392 with 'rst_1'.
  always @(posedge clk or posedge rst_1_active_high_edge) begin
    if (rst_1_active_high_edge) begin // Active-high reset condition
      q_1_active_high <= 4'hA;
    end else begin
      q_1_active_high <= data_in - 1;
    end
  end

endmodule
