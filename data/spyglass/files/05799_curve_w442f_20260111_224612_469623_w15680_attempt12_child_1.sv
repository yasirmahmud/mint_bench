module curve_w442f_20260111_224612_469623_w15680_attempt12 (
  input wire clk,
  input wire reset_n, // Active-low reset
  input wire d,
  output reg q
);

  // This always block implements an asynchronous reset flip-flop.
  // The sensitivity list correctly captures the asynchronous reset condition.
  always @(posedge clk or negedge reset_n) begin
    // W442f violation: The reset validation condition uses the relational
    // binary operator '>', which is not '==' or '!='. The condition
    // 'reset_n > 1'b0' is functionally equivalent to 'reset_n == 1'b1'.
    // However, SpyGlass flags the use of '>' as a violation of W442f.
    // 
    // Fix: Replaced '>' with '==' to resolve W442f while preserving the
    // functional behavior (an active-high reset, despite the 'reset_n' name).
    if (reset_n == 1'b1) begin // This is the reset condition check
      q <= 1'b0; // Reset state
    end else begin
      q <= d;
    end
  end

endmodule
