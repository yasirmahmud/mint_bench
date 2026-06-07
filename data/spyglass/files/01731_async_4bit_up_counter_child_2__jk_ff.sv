module jk_ff(
  input clk,
  input J,
  input K,
  output reg Q
);

  always @(negedge clk) begin
    if (J == 1'b1 && K == 1'b1) begin
      Q <= ~Q; // Toggle
    end else if (J == 1'b1 && K == 1'b0) begin
      Q <= 1'b1; // Set
    end else if (J == 1'b0 && K == 1'b1) begin
      Q <= 1'b0; // Reset
    end
    // For J=0, K=0 (Hold), no assignment is needed, as 'Q' will retain its current value.
  end
endmodule
