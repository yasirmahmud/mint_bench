module curve_starc05_1_2_1_2_20260111_193735_888802_w7792_attempt10 (
  input wire s_bar_in,  // Active-low Set input
  input wire r_bar_in,  // Active-low Reset input
  output reg q_out     // Main output
);

  // Behavioral model of an active-low RS latch.
  // This replaces the cross-coupled NAND gates to resolve the CombLoop
  // and STARC05-1.2.1.2 violations, while preserving the functional behavior.
  // The `always` block infers a latch, which is typically desired over
  // a gate-level implementation for synthesis.
  // In the case of the forbidden state (s_bar_in=0, r_bar_in=0),
  // this model prioritizes reset, setting q_out to 0.

  always @(s_bar_in or r_bar_in) begin
    if (!r_bar_in) begin // Active-low Reset is asserted
      q_out = 1'b0;
    end else if (!s_bar_in) begin // Active-low Set is asserted (and Reset is not)
      q_out = 1'b1;
    end
    // If both r_bar_in and s_bar_in are high (inactive),
    // the latch holds its current state (implicit by no assignment).
  end

endmodule
