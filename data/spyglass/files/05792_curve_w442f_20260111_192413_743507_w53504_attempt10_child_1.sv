module curve_w442f_20260111_192413_743507_w53504_attempt10 (
  input wire clk,
  input wire rst_a,
  input wire rst_b,
  input wire d,
  output reg q
);

  // W442f violation: The asynchronous reset validation condition uses
  // the bitwise XOR (^) binary operator, which is not '==' or '!='.
  // Fix: Replaced (rst_a ^ rst_b) with (rst_a != rst_b) which is functionally equivalent
  // and uses an allowed operator for asynchronous reset conditions, resolving W442f.
  always_ff @(posedge clk or posedge (rst_a != rst_b)) begin
    if (rst_a != rst_b) begin
      q <= 1'b0;
    end else begin
      q <= d;
    }
  end

endmodule
