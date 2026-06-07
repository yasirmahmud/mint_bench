module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  reg latched_enable;

  // Behavioral model for a high-enable clock gating latch with test enable
  // The latch is transparent when CK is high.
  // When CK is low, it holds its last value.
  // The enable signal is the logical OR of E and SE.
  always @(CK or E or SE) begin
    if (CK) begin // Latch is transparent when CK is high
      latched_enable = (E | SE);
    end
    // When CK is low, latched_enable holds its value (implied by 'reg' and no 'else')
  end

  // The gated clock is the input clock ANDed with the latched enable
  assign GCK = CK & latched_enable;

endmodule
