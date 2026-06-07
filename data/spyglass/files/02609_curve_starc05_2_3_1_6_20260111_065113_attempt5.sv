module curve_starc05_2_3_1_6_20260111_065113_attempt5 (
  input wire clk,
  input wire rst,
  input wire d_in,
  output reg q_out
);

  // This always block describes a D-flip-flop with an asynchronous reset.
  // The sensitivity list includes 'negedge rst', implying an active-low asynchronous reset.
  // However, the 'if' condition checks for an active-high reset level (rst).
  // This discrepancy between the reset edge specified in the sensitivity list
  // and the logic level checked in the 'if' condition triggers STARC05-2.3.1.6.
  // This example uses 'posedge clk' and 'negedge rst' in sensitivity,
  // with an 'if (rst)' condition, making it distinct from previous attempts.
  always @(posedge clk or negedge rst) begin
    if (rst) begin // STARC05-2.3.1.6 violation: negedge rst in sensitivity, but active-high level check
      q_out <= 1'b0;
    end else begin
      q_out <= d_in;
    end
  end

endmodule
