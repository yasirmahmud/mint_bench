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

  // Block 1 for rst_0: Uses rst_0 as an asynchronous active-low reset.
  // This usage, combined with Block 2, will contribute to W392 violations for rst_0.
  always @(posedge clk or negedge rst_0) begin
    if (!rst_0) begin // Active-low reset condition
      q_0_active_low <= 4'h0;
    end else begin
      q_0_active_low <= data_in;
    end
  end

  // Block 2 for rst_0: Uses the SAME rst_0 signal as an asynchronous active-high reset.
  // This conflicting usage (with Block 1) for rst_0 will trigger W392. This is the second W392 context for rst_0.
  always @(posedge clk or posedge rst_0) begin
    if (rst_0) begin // Active-high reset condition
      q_0_active_high <= 4'hF;
    end else begin
      q_0_active_high <= data_in;
    end
  end

  // Block 3 for rst_1: Uses rst_1 as an asynchronous active-low reset.
  // This usage, combined with Block 4, will contribute to W392 violations for rst_1.
  always @(posedge clk or negedge rst_1) begin
    if (!rst_1) begin // Active-low reset condition
      q_1_active_low <= 4'h5;
    end else begin
      q_1_active_low <= data_in + 1;
    end
  end

  // Block 4 for rst_1: Uses the SAME rst_1 signal as an asynchronous active-high reset.
  // This conflicting usage (with Block 3) for rst_1 will trigger W392. This is the second W392 context for rst_1.
  always @(posedge clk or posedge rst_1) begin
    if (rst_1) begin // Active-high reset condition
      q_1_active_high <= 4'hA;
    end else begin
      q_1_active_high <= data_in - 1;
    end
  end

endmodule
