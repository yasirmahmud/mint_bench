module curve_w442f_20260111_224612_469623_w15680_attempt11 (
  input wire clk,
  input wire rst_a,
  input wire rst_b,
  input wire d,
  output reg q
);

  // This always block implements an asynchronous reset flip-flop.
  // The sensitivity list correctly captures the asynchronous reset condition.
  always @(posedge clk or posedge (rst_a || rst_b)) begin
    // W442f violation: The reset validation condition uses the logical OR '||'
    // binary operator. This rule requires only '==' or '!=' in the reset condition.
    if (rst_a || rst_b) begin
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end

endmodule
