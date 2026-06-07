module CLKGATETST_X1 (
  input CK,  // Clock
  input E,   // Enable
  input SE,  // Test Enable
  output GCK // Gated Clock
);

  reg enable_latch;

  // Behavioral model for a transparent latch: transparent when CK is low, holds when CK is high
  always @(E or CK) begin
    if (!CK) begin // Latch is transparent when CK is low
      enable_latch = E;
    end
    // When CK is high, the latch holds its value. This is implicitly inferred by not assigning to enable_latch in the else branch.
  end

  // Gated clock generation logic
  assign GCK = (SE) ? CK : (CK & enable_latch);

endmodule // CLKGATETST_X1
