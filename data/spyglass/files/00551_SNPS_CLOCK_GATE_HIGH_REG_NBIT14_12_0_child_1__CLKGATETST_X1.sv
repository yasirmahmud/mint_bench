module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  // Internal signal for the latched enable
  reg  enable_latched;

  // Level-sensitive latch for the enable signal 'E'.
  // This latch is transparent when 'CK' is low and holds its value when 'CK' is high.
  // This behavior is typical for the enable latch within a positive-edge clock gating cell.
  always @(CK or E) begin
    if (!CK) begin // When clock is low, latch is transparent
      enable_latched <= E;
    end
    // else, it holds its value when CK is high
  end

  // Gated clock generation logic.
  // If 'SE' (Test Enable) is high, the clock 'CK' is passed directly to 'GCK' (bypass mode).
  // Otherwise, 'GCK' is the logical AND of 'CK' and the latched enable signal 'enable_latched'.
  assign GCK = SE ? CK : (CK & enable_latched);

endmodule
