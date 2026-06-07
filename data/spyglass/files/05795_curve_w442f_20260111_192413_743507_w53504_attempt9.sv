module curve_w442f_20260111_192413_743507_w53504_attempt9 (
  input wire clk,
  input wire reset_a_n,
  input wire reset_b_n,
  input wire d,
  output reg q
);

  // W442f violation: The asynchronous reset validation condition uses
  // the logical AND (&&) binary operator, which is not '==' or '!='.
  // This directly reflects the context examples provided.
  always_ff @(posedge clk or negedge (reset_a_n && reset_b_n)) begin
    if (!(reset_a_n && reset_b_n)) begin
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end

endmodule
