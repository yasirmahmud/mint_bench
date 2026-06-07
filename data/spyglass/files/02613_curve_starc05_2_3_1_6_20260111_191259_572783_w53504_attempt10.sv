module curve_starc05_2_3_1_6_20260111_191259_572783_w53504_attempt10 (
  input wire clk,
  input wire rst, // Reset signal for violation
  input wire d,
  output reg q
);

  // This always block implements a D-type flip-flop.
  // The sensitivity list includes 'posedge rst', implying an active-high asynchronous reset.
  // However, the conditional statement inside the block checks 'if (!rst)',
  // which looks for an active-low state for the reset condition.
  // This discrepancy between the edge specified in the sensitivity list (posedge)
  // and the logic level checked in the condition (active-low) triggers the STARC05-2.3.1.6 rule.
  // The reset action sets 'q' to 0, which is a standard reset behavior,
  // making it less likely to trigger SYNTH_5192. The asynchronous reset check
  // 'if (!rst)' is the first condition, which helps avoid the badimplicitSM1 violation.
  always @(posedge clk or posedge rst) begin
    if (!rst) begin // STARC05-2.3.1.6 violation: posedge rst in sensitivity list, but checks for !rst
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end

endmodule
