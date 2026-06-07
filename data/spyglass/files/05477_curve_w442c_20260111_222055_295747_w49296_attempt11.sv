`timescale 1ns / 1ps

module curve_w442c_20260111_222055_295747_w49296_attempt11 (
  input wire clk,
  input wire rst,
  input wire enable_reset, // Additional control for complex reset condition
  input wire disable_reset, // Additional control for complex reset condition
  input wire data_in1,
  input wire data_in2,
  input wire data_in3,
  input wire data_in4,
  output reg q1,
  output reg q2,
  output reg q3,
  output reg q4
);

  // W442c violation 1: Reset condition is a logical AND expression.
  // Rule: Asynchronous reset/set always block may have the reset/set condition only as a simple identifier or its negation (! or ~)
  always @(posedge clk or posedge rst) begin
    if (rst && enable_reset) begin // ERROR: W442c violation here
      q1 <= 1'b0;
    end else begin
      q1 <= data_in1;
    end
  end

  // W442c violation 2: Reset condition is a logical OR expression involving negation.
  always @(posedge clk or posedge rst) begin
    if (!rst || disable_reset) begin // ERROR: W442c violation here
      q2 <= 1'b1; // Set to 1 for variety
    end else begin
      q2 <= data_in2;
    end
  end

  // W442c violation 3: Reset condition is an explicit comparison expression.
  always @(posedge clk or posedge rst) begin
    if (rst == 1'b1) begin // ERROR: W442c violation here
      q3 <= 1'b0;
    end else begin
      q3 <= data_in3;
    end
  end

  // W442c violation 4: Reset condition is a ternary (conditional) operator expression.
  always @(posedge clk or posedge rst) begin
    if (rst ? enable_reset : 1'b0) begin // ERROR: W442c violation here
      q4 <= 1'b0;
    end else begin
      q4 <= data_in4;
    end
  end

endmodule
