module curve_synth_5192_20260111_190645_396447_w37940_attempt9 (
  input wire clk,
  input wire reset_p, // Active-low reset signal, intentionally named '_p' to differentiate
  input wire din,
  output reg dout
);

  // SYNTH_5192 violation: The sensitivity list specifies a negative edge for 'reset_p',
  // which implies 'reset_p' is an active-low reset. However, the 'if' condition
  // checks for 'reset_p' being high (1'b1), which is the inactive state for an
  // active-low reset. This creates a mismatch between the implied active edge (negative)
  // and the logic level checked in the reset condition (high).
  always @(posedge clk or negedge reset_p) begin
    if (reset_p) begin // Condition checks for reset_p being high (inactive state for negedge reset)
      dout <= 1'b0; // This value is assigned when reset_p is high
    end else begin
      dout <= din;
    end
  end

endmodule
