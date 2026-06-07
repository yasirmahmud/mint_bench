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

  // First asynchronous reset block triggers one W442b violation.
  // Rule W442b: Comparison of an active-high asynchronous reset signal (rst_a)
  // to a non-constant expression (data_a) in the reset condition.
  always @(posedge clk or posedge rst_a) begin
    if (rst_a == data_a) begin // W442b violation here
      q_a <= 1'b0;
    end else begin
      q_a <= in_a;
    end
  end

  // Second asynchronous reset block triggers a second W442b violation.
  // This uses a different reset signal and data, ensuring two distinct occurrences.
  always @(posedge clk or posedge rst_b) begin
    if (rst_b == data_b) begin // W442b violation here
      q_b <= 1'b1;
    end else begin
      q_b <= in_b;
    end
  end

endmodule
