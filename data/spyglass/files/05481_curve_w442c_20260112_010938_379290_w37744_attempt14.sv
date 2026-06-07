module curve_w442c_20260112_010938_379290_w37744_attempt14 (
  input wire clk,
  input wire rst,
  input wire d,
  output reg q
);

  // A simple function to encapsulate a reset condition check.
  // According to W442c, the reset condition in an asynchronous
  // always block must be a simple identifier or its negation.
  // A function call is not considered a simple identifier or its negation.
  function automatic logic is_reset_active(input logic reset_signal);
    return reset_signal;
  endfunction

  // W442c violation: The asynchronous reset condition is a function call,
  // not a simple identifier ('rst') or its negation ('!rst' or '~rst').
  always @(posedge clk or posedge rst) begin
    if (is_reset_active(rst)) begin // W442c violation
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end

endmodule
