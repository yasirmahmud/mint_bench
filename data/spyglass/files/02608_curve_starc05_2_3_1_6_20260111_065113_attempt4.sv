module curve_starc05_2_3_1_6_20260111_065113_attempt4 (
  input wire clk,
  input wire rst,
  input wire d_in,
  output reg q_out
);

  // This always block describes a D-flip-flop with an asynchronous reset.
  // The sensitivity list includes 'posedge rst', implying an active-high asynchronous reset.
  // However, the 'if' condition checks for an active-low reset level (~rst).
  // This discrepancy between the reset edge specified in the sensitivity list
  // and the logic level checked in the 'if' condition triggers STARC05-2.3.1.6.
  // This example is distinct from previous attempts by using a 'negedge clk' for the clock.
  always @(negedge clk or posedge rst) begin
    if (~rst) begin // STARC05-2.3.1.6 violation: posedge rst in sensitivity, but active-low level check
      q_out <= 1'b0; // Asynchronous reset value
    end else begin
      q_out <= d_in; // Data path on clock edge
    end
  end

endmodule
