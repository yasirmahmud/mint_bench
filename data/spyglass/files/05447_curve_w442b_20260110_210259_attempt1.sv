module curve_w442b_20260110_210259_attempt1 (
  input wire clk,
  input wire rst_n_a, // Active low asynchronous reset for q_a
  input wire rst_n_b, // Active low asynchronous reset for q_b
  input wire data_in_a, // Non-constant expression for q_a's reset condition
  input wire data_in_b, // Non-constant expression for q_b's reset condition
  output reg q_a,
  output reg q_b
);

  // First asynchronous reset block
  // This block triggers the first W442b violation.
  always @(posedge clk or negedge rst_n_a) begin
    // W442b violation: rst_n_a (asynchronous reset signal) is compared to data_in_a (a non-constant expression)
    if (rst_n_a == data_in_a) begin
      q_a <= 1'b0; // Asynchronous reset condition
    end else begin
      q_a <= ~q_a; // Example sequential logic
    end
  end

  // Second asynchronous reset block
  // This block triggers the second W442b violation, ensuring total occurrences count of 2.
  always @(posedge clk or negedge rst_n_b) begin
    // W442b violation: rst_n_b (asynchronous reset signal) is compared to data_in_b (a non-constant expression)
    if (rst_n_b == data_in_b) begin
      q_b <= 1'b0; // Asynchronous reset condition
    end else begin
      q_b <= ~q_b; // Example sequential logic
    end
  end

endmodule
