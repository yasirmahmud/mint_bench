module curve_synth_5192_20260111_190645_396447_w37940_attempt10 (
  input wire clk,
  input wire rst,
  input wire d,
  output reg q
);

  // SYNTH_5192 violation: The sensitivity list specifies 'posedge rst',
  // which implies an active-high asynchronous reset. However, the 'if'
  // condition checks for '~rst' (rst being low), which is the inactive
  // state for an active-high reset. This creates a mismatch between the
  // implied active edge and the logic level checked in the reset condition.
  always @(posedge clk or posedge rst) begin
    if (~rst) begin // Condition checks for rst being low (active-low logic for an active-high edge)
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end

endmodule
