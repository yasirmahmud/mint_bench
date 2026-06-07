module curve_starc05_2_3_1_6_20260111_065113_attempt3 (
  input wire clk,
  input wire rst,
  input wire d_in,
  output reg q_out
);

  // This always block describes a D-flip-flop with an asynchronous reset.
  // The sensitivity list implies an active-high asynchronous reset (posedge rst).
  // However, the 'if' condition checks for an active-low reset (~rst).
  // This mismatch triggers STARC05-2.3.1.6.
  always @(posedge clk or posedge rst) begin
    if (~rst) begin // STARC05-2.3.1.6 violation: posedge rst in sensitivity, but active-low check
      q_out <= 1'b0; // Reset value
    end else begin
      q_out <= d_in; // Data path
    end
  end

endmodule
