module CLKGATETST_X1 (
    input CK,
    input E,
    input SE,
    output GCK
);
  reg en_q;

  // Modified sensitivity list from `always @*` to `always @(E or SE or CK)`.
  // This explicitly declares the sensitivity of the latch to its inputs and the clock/enable signal.
  // This change preserves the functional behavior of the intentional latch while potentially
  // satisfying linting rules that prefer explicit sensitivity lists for latches.
  always @(E or SE or CK) begin
    if (!CK) begin // Latch is transparent when CK is low
      en_q = E | SE; // Enable or Test Enable
    end
    // When CK is high, en_q holds its value (latch opaque). This implicit behavior
    // is what creates the latch, and it is preserved as per the design description.
  end

  assign GCK = CK & en_q; // GCK is high only when CK is high AND en_q is high
endmodule
