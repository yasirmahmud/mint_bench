module CLKGATETST_X1 (CK, E, SE, GCK);

  input CK, E, SE;
  output GCK;

  reg en_latch;

  // Latch the enable signal 'E' when 'CK' is low (negative-level sensitive latch)
  // When CK is high, the latch holds its value.
  always @(E or CK) begin
    if (!CK) begin
      en_latch = E;
    end
  end

  // Gated clock logic:
  // If SE (Test Enable) is high, GCK directly follows CK.
  // Else (SE is low), GCK follows CK only if en_latch is high and CK is high.
  // Otherwise, GCK is held low.
  assign GCK = SE ? CK : (en_latch && CK);

endmodule
