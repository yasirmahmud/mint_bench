// Definition of CLKGATETST_X1 to resolve the black-box violation.
// This implements a glitch-free clock gate using a negative-level sensitive latch
// for the enable signal (E OR SE) and an AND gate for the final output.
module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  reg L_EN; // Latched Enable signal

  // Negative-level sensitive latch for L_EN
  // It is transparent when CK is low (active_low enable for transparency).
  // It holds its value when CK is high.
  always @(*) begin
    if (~CK) begin
      L_EN = E | SE; // Latch input is E OR SE
    end
    // else, L_EN holds its previous value when CK is high
  end

  // Gated clock output: only allow CK to pass when L_EN is high
  assign GCK = CK & L_EN;

endmodule
