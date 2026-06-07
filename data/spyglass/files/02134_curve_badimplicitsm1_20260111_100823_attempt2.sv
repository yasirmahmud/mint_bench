module curve_badimplicitsm1_20260111_100823_attempt2 (
  input clk,
  input rst, // Asynchronous reset signal
  input control_signal,
  output reg q
);

  // This always block detects a positive edge of clk or rst.
  // The 'badimplicitSM1' rule expects asynchronous reset signals (like 'rst')
  // to be checked first in an 'if-else if' chain within the procedural block.
  always @(posedge clk or posedge rst) begin
    if (control_signal) begin // Violation: 'control_signal' is checked before 'rst'.
      q <= ~q; // Toggle q on control_signal if rst is not asserted.
    end else if (rst) begin // 'rst' should have been checked first.
      q <= 1'b0; // Asynchronous reset action
    end else begin
      q <= q; // Hold current state
    end
  end

endmodule
