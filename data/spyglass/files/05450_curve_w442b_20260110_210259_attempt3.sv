module curve_w442b_20260110_210259_attempt3 (
  input wire clk,
  input wire rst_a_n,       // Active-low asynchronous reset for q_a
  input wire rst_b_n,       // Active-low asynchronous reset for q_b
  input wire data_val_a,    // Non-constant expression for q_a's reset condition
  input wire data_val_b,    // Non-constant expression for q_b's reset condition
  input wire input_d_a,     // Data input for q_a
  input wire input_d_b,     // Data input for q_b
  output reg q_a,
  output reg q_b
);

  // First asynchronous reset block triggers one W442b violation.
  // Rule W442b: Comparison of an active-low asynchronous reset signal (rst_a_n)
  // to a non-constant expression (data_val_a) in the reset condition.
  always @(posedge clk or negedge rst_a_n) begin
    if (rst_a_n == data_val_a) begin
      q_a <= 1'b1; // Reset to a different value for distinctness
    end else begin
      q_a <= input_d_a;
    end
  end

  // Second asynchronous reset block triggers a second W442b violation.
  // Rule W442b: Comparison of an active-low asynchronous reset signal (rst_b_n)
  // to a non-constant expression (data_val_b) in the reset condition.
  always @(posedge clk or negedge rst_b_n) begin
    if (rst_b_n == data_val_b) begin
      q_b <= 1'b0;
    end else begin
      q_b <= input_d_b ^ q_b; // Different logic in else branch for distinctness
    end
  end

endmodule
