module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  reg E_latched;

  // A common implementation for a clock gate with test enable (SE).
  // The enable 'E' is latched when the clock 'CK' is low (negative phase).
  // The 'SE' signal provides a test bypass, forcing the latched enable high
  // when 'SE' is active, thus ensuring the clock is always passed.
  always @(E or SE or CK) begin
    if (!CK) begin // Latch is transparent when CK is low
      E_latched = E | SE; // If SE is high, E_latched will become high when CK is low
    end
  end

  // Gate the clock 'CK' with the latched enable 'E_latched'.
  // If SE was high, E_latched is forced high, making GCK = CK.
  // If SE was low, E_latched tracks E, making GCK = E_latched & CK (glitch-free gating).
  assign GCK = E_latched & CK;

endmodule
