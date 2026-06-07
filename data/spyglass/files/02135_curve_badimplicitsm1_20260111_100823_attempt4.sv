module curve_badimplicitsm1_20260111_100823_attempt4 (
  input clk,
  input rst, // Asynchronous reset signal
  input d,   // Data input
  output reg q
);

  // This always block detects a positive edge of clk or rst.
  // The 'badimplicitSM1' rule expects asynchronous reset signals (like 'rst')
  // to be checked first in an 'if-else if' chain within the procedural block.
  always @(posedge clk or posedge rst) begin
    if (d) begin // Violation: 'd' is checked before 'rst'.
      q <= 1'b1; // Set q based on data if rst is not asserted.
    end else if (rst) begin // 'rst' should have been checked first.
      q <= 1'b0; // Asynchronous reset action
    end else begin
      q <= q; // Maintain current state if no other condition met
    end
  end

endmodule
