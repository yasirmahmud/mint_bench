module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  reg latched_E;

  // Positive level-sensitive latch for the enable signal 'E'
  // 'latched_E' follows 'E' when 'CK' is high, and holds when 'CK' is low.
  always @(E or CK) begin
    if (CK) begin
      latched_E = E;
    end
  end

  // The gated clock (GCK) is the input clock (CK) ANDed with the latched enable
  // or the test enable (SE). 'SE' typically forces the gate open for test.
  assign GCK = CK & (latched_E | SE);

endmodule
