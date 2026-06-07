module curve_w442b_20260110_210259_attempt4 (
  input wire clk,
  input wire rst_a,
  input wire rst_b,
  input wire data_a,
  input wire data_b,
  input wire in_a,
  input wire in_b,
  output reg q_a,
  output reg q_b
);

  // First asynchronous reset block, fixed W442b violation.
  // The condition for an active-high asynchronous reset should compare the reset signal
  // to a constant value (implicitly 1'b1 when used directly).
  always @(posedge clk or posedge rst_a) begin
    if (rst_a) begin // Fixed W442b: rst_a is implicitly compared to 1'b1 (constant)
      q_a <= 1'b0;
    end else begin
      q_a <= in_a;
    end
  end

  // Second asynchronous reset block, fixed second W442b violation.
  // Similar to the first, the reset condition for an active-high asynchronous reset
  // should be based solely on the reset signal itself.
  always @(posedge clk or posedge rst_b) begin
    if (rst_b) begin // Fixed W442b: rst_b is implicitly compared to 1'b1 (constant)
      q_b <= 1'b1;
    end else begin
      q_b <= in_b;
    end
  end

endmodule
