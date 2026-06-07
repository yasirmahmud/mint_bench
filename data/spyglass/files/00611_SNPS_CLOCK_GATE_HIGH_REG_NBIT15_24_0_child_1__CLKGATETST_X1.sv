module CLKGATETST_X1 (CK, E, SE, GCK);
  input CK, E, SE;
  output GCK;

  reg en_internal; // Latched enable signal

  // Positive-level sensitive latch for enable 'E', controlled by 'CK'
  // When CK is high, the latch is transparent and passes 'E'.
  // When CK is low, the latch holds its last value.
  always @(CK or E) begin
    if (CK) begin 
      en_internal = E;
    end
  end

  // Gated clock output 'GCK'
  // GCK is 'CK' AND-ed with (latched enable 'en_internal' OR test enable 'SE').
  // This implies that if 'SE' is high, the gate is forced open, allowing 'CK' to pass.
  assign GCK = CK & (en_internal | SE);
endmodule
