module curve_w442b_20260110_210259_attempt2 (
  input wire clk,
  input wire rst_a,       // Active high asynchronous reset for q_a
  input wire rst_b,       // Active high asynchronous reset for q_b
  input wire data_a,      // Non-constant expression for q_a's reset condition
  input wire data_b,      // Non-constant expression for q_b's reset condition
  output reg q_a,
  output reg q_b
);

  // First asynchronous reset block triggers one W442b violation.
  // Rule W442b: Comparison of an asynchronous reset signal (rst_a) to a non-constant expression (data_a)
  always @(posedge clk or posedge rst_a) begin
    if (rst_a == data_a) begin
      q_a <= 1'b0;
    end else begin
      q_a <= data_a;
    end
  end

  // Second asynchronous reset block triggers a second W442b violation.
  // Rule W442b: Comparison of an asynchronous reset signal (rst_b) to a non-constant expression (data_b)
  always @(posedge clk or posedge rst_b) begin
    if (rst_b == data_b) begin
      q_b <= 1'b1;
    end else begin
      q_b <= ~data_b;
    end
  end

endmodule
