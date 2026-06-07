module CLKGATETST_X1 ( input CK, input E, input SE, output GCK );
  reg latch_out;

  // Behavioral model for a clock gating cell's internal latch
  // Latch is transparent when CK is low, holding its value when CK is high.
  // The input to the latch is (E | SE).
  always @(CK or E or SE) begin
    if (~CK) begin
      latch_out = E | SE;
    end
    // else latch_out implicitly holds its value when CK is high
  end

  // Gated clock output is CK ANDed with the latch output
  assign GCK = CK & latch_out;

endmodule
