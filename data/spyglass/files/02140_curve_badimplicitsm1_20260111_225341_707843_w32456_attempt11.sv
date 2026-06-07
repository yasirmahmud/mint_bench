module curve_badimplicitsm1_20260111_225341_707843_w32456_attempt11 (
  input clk,
  input rst, // Asynchronous active-high reset
  input data_in,
  input control_sig,
  output reg q
);

  always @(posedge clk or posedge rst) begin
    // Violation: The 'control_sig' condition is checked before the asynchronous reset 'rst'.
    // Rule badimplicitSM1 requires asynchronous reset/set signals to be checked first in an if-else if chain.
    if (control_sig) begin
      q <= data_in;
    end else if (rst) begin
      q <= 1'b0;
    end else begin
      // Synchronous behavior or maintain state
      q <= q;
    end
  end

endmodule
