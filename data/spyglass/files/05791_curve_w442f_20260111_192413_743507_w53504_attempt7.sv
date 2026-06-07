module curve_w442f_20260111_192413_743507_w53504_attempt7 (
  input wire clk,
  input wire reset_n, // Active low asynchronous reset
  input wire d,
  output reg q
);

  always_ff @(posedge clk or negedge reset_n) begin
    // W442f violation: The asynchronous reset validation condition uses the
    // binary relational operator '<' instead of '==' or '!='. The condition
    // 'reset_n < 1'b1' is functionally equivalent to 'reset_n == 1'b0'.
    if (reset_n < 1'b1) begin
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end

endmodule
