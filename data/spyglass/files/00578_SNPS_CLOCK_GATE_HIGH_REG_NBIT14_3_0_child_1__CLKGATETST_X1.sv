module CLKGATETST_X1 (CK, E, SE, GCK);
  input CK, E, SE;
  output GCK;

  reg latched_E;

  // Behavioral model of a negative-transparent latch for the enable signal.
  // The latch is transparent when CK is low, capturing the value of E.
  // It holds its value when CK is high.
  always @(E or CK) begin
    if (~CK) begin // Latch is transparent when CK is low
      latched_E = E;
    end
  end

  // The gated clock output.
  // If SE (test enable) is high, the clock passes through irrespective of E.
  // Otherwise, the clock passes through only if the latched enable (latched_E) is high.
  assign GCK = SE ? CK : (CK & latched_E);

endmodule
