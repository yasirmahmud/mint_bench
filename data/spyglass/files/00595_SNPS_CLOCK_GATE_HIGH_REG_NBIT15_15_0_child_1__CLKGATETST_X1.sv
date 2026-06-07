module CLKGATETST_X1 (
  input CK,  // Clock input
  input E,   // Functional enable
  input SE,  // Scan Enable (Test Enable)
  output GCK // Gated Clock output
);

  reg enable_latched; // Latch to hold the enable signal

  // The enable signal 'E' is latched when 'CK' is low.
  // This ensures 'enable_latched' is stable when 'CK' transitions high,
  // preventing glitches on the gated clock. This represents a negative-level-sensitive latch.
  always @(CK or E) begin
    if (!CK) begin // Transparent when CK is low
      enable_latched = E;
    end
    // When CK is high, enable_latched holds its last value (from when CK was low)
  end

  // The gated clock GCK is high only when CK is high AND
  // (the latched enable is high OR the scan enable is high).
  // If SE is high, the clock is always passed, bypassing the functional enable.
  assign GCK = CK & (enable_latched | SE);

endmodule
