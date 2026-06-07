module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  reg q_latch; // Internal latch state for the enable signal

  // Level-sensitive latch: transparent when CK is low, holds when CK is high.
  // This is a common behavior for clock gating enables, where the enable
  // signal 'E' is sampled when the clock 'CK' is low.
  always @(E or CK) begin
    if (!CK) begin // When CK is low, the latch is transparent and captures E
      q_latch = E;
    end
    // When CK is high, q_latch holds its current value (the value of E when CK went high).
  end

  // The gated clock output: CK is enabled if the latched enable (q_latch) is high,
  // or if the scan/test enable (SE) is high (bypassing the normal enable).
  assign GCK = CK && (q_latch || SE);

endmodule
