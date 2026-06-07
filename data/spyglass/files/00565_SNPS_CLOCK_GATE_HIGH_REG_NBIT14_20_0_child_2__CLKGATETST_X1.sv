module CLKGATETST_X1 ( CK, E, SE, GCK );
  input CK, E, SE;
  output GCK;

  reg latch_q;
  wire gated_clock_int;

  // D-latch transparent when CK is low.
  // This latch samples the enable signal 'E' when CK is low,
  // ensuring a glitch-free enable transition for the clock gate.
  // Using 'always_latch' explicitly indicates intent for a latch, resolving 'InferLatch' violation.
  always_latch begin 
    if (!CK) begin // Latch is transparent when CK is low
      latch_q = E;
    end
    // When CK is high, the latch holds its current value (implicit latch behavior).
  end

  // Main clock gating logic: clock is gated by the latched enable signal.
  assign gated_clock_int = latch_q && CK;

  // Test enable (SE) provides a bypass mechanism.
  // If SE is high, GCK directly follows CK (test mode).
  // If SE is low, GCK is the result of the normal clock gating operation.
  assign GCK = SE ? CK : gated_clock_int;

endmodule
