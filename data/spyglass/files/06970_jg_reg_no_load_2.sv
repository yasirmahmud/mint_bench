module UnusedRegisterExample2 (
  input clk,
  input rst_n,
  input in_a,
  input in_b
);

  logic unused_reg_a; // Flip-flop A
  logic unused_reg_b; // Flip-flop B

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      unused_reg_a <= 1'b0;
      unused_reg_b <= 1'b0;
    end else begin
      unused_reg_a <= in_a;
      unused_reg_b <= in_b;
    end
  end

  // Neither unused_reg_a nor unused_reg_b are ever read or used.

endmodule
