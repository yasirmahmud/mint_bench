module curve_w442f_20260111_192413_743507_w53504_attempt6 (
  input wire clk,
  input wire reset_a,
  input wire reset_b,
  input wire d,
  output reg q
);

  // Asynchronous reset is active low based on the XNOR of reset_a and reset_b
  always_ff @(posedge clk or negedge (reset_a ~^ reset_b)) begin
    // W442f violation: The reset validation condition uses the binary XOR operator '^'
    // instead of '==' or '!='. The condition is equivalent to checking if (reset_a ~^ reset_b) is 0.
    if ((reset_a ~^ reset_b) ^ 1'b1) begin
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end

endmodule
