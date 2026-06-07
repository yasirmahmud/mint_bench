module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output reg GCK
);

  // Behavioral model for a latch-based clock gating cell
  // GCK follows CK when enabled (E or SE is high).
  // When not enabled, GCK holds its last value (latch behavior).
  always @(CK or E or SE) begin
    if (E | SE) begin // Clock is enabled either by normal enable (E) or test enable (SE)
      GCK = CK;
    end
    // else, GCK holds its last value (implicit latch behavior)
  end

endmodule
