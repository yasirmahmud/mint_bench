module curve_w442c_20260112_010938_379290_w37744_attempt13 (
  input wire clk,
  input wire rst,
  input wire d1,
  input wire d2,
  input wire d3,
  input wire d4,
  output reg q1,
  output reg q2,
  output reg q3,
  output reg q4
);

  // Function to encapsulate reset condition check
  // Using a function call for the reset condition is a violation
  // because it's not a simple identifier 'rst' or its negation.
  function automatic logic get_reset_cond(input logic reset_signal);
    return reset_signal;
  endfunction

  // W442c violation 1: Reset condition is a function call
  always @(posedge clk or posedge rst) begin
    if (get_reset_cond(rst)) begin // W442c violation: Reset condition is a function call
      q1 <= 1'b0;
    end else begin
      q1 <= d1;
    end
  end

  // W442c violation 2: Reset condition is a logical OR expression with a constant
  // Even though (rst | 1'b0) simplifies to 'rst', syntactically it is not a simple identifier.
  always @(posedge clk or posedge rst) begin
    if (rst | 1'b0) begin // W442c violation: Reset condition is an expression (logical OR)
      q2 <= 1'b0;
    end else begin
      q2 <= d2;
    end
  end

  // W442c violation 3: Reset condition is a comparison expression
  // 'rst == 1'b1' is an expression, not a simple identifier 'rst'.
  always @(posedge clk or posedge rst) begin
    if (rst == 1'b1) begin // W442c violation: Reset condition is an expression (comparison)
      q3 <= 1'b0;
    end else begin
      q3 <= d3;
    end
  end

  // W442c violation 4: Reset condition uses a bit-select on a single-bit signal
  // 'rst[0]' is an expression/part-select, not a simple identifier 'rst'.
  always @(posedge clk or posedge rst) begin
    if (rst[0]) begin // W442c violation: Reset condition is an expression (bit-select)
      q4 <= 1'b0;
    end else begin
      q4 <= d4;
    end
  end

endmodule
