module CLKGATETST_X1 (
    input CK,
    input E,
    input SE,
    output GCK
);

  reg enable_latch_q;

  // This latch is transparent when CK is low (negative phase of clock).
  // It captures the effective enable signal.
  // If SE is high, it forces the enable_latch_q to 1'b1 (clock always enabled during test).
  // Otherwise, it captures the functional enable E when CK is low.
  always @(E or CK or SE) begin
    if (SE) begin
      enable_latch_q <= 1'b1; // In test mode, force clock gate open
    end else if (!CK) begin   // When clock is low, latch is transparent
      enable_latch_q <= E;
    end
    else begin // when CK is high and not in test mode, latch holds its value.
      enable_latch_q <= enable_latch_q;
    end
  end

  // The gated clock is the input clock ANDed with the output of the enable latch.
  // This ensures a glitch-free clock output.
  assign GCK = CK & enable_latch_q;

endmodule
