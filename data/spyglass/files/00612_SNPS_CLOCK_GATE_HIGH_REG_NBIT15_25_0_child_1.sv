module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  reg enable_latched_q;

  // This models a transparent latch for the enable signal.
  // The latch is transparent when CK is low, capturing the OR of E and SE.
  // When CK is high, the latch holds its last value.
  always @(E or SE or CK) begin
    if (~CK) begin // When CK is low, latch is transparent
      enable_latched_q = E | SE;
    end
    // else (CK is high), enable_latched_q holds its value.
  end

  // The gated clock output is the AND of the input clock and the latched enable.
  assign GCK = enable_latched_q & CK;

endmodule
