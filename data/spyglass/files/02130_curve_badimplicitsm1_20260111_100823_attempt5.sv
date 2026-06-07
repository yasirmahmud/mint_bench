module curve_badimplicitsm1_20260111_100823_attempt5 (
  input clk,
  input rst, // Asynchronous reset
  input set_val, // Input to set q_val
  input clear_val, // Input to clear q_val
  output reg [1:0] q_val
);

  // This always block detects a positive edge of clk or rst.
  // The 'badimplicitSM1' rule expects asynchronous reset signals (like 'rst')
  // to be checked first in an 'if-else if' chain within the procedural block.
  always @(posedge clk or posedge rst) begin
    if (set_val) begin // Violation: 'set_val' is checked before 'rst'.
      q_val <= 2'b10; // Set q_val to a specific value
    end else if (clear_val) begin // Violation: 'clear_val' is also checked before 'rst'.
      q_val <= 2'b00; // Clear q_val
    end else if (rst) begin // 'rst' should have been checked first.
      q_val <= 2'b00; // Asynchronous reset action
    end else begin
      q_val <= q_val; // Maintain current state if no other condition met
    end
  end

endmodule
