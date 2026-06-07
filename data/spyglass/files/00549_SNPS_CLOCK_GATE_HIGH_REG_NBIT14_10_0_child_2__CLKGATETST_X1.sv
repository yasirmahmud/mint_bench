module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  wire q_latch_out; // Output of the instantiated latch

  // Instantiate a generic negative-enable latch for the enable signal. 
  // This resolves the "latch inferred" violation by explicitly instantiating 
  // a dedicated latch module instead of inferring it behaviorally within CLKGATETST_X1.
  LATCH_N_GENERIC the_enable_latch (
    .EN_N(!CK),         // Latch is transparent when CK is low (active low enable)
    .D(E),              // Data input is the enable signal 'E'
    .Q(q_latch_out)     // Output of the latch, representing the latched enable
  );

  // The gated clock output: CK is enabled if the latched enable (q_latch_out) is high,
  // or if the scan/test enable (SE) is high (bypassing the normal enable).
  assign GCK = CK && (q_latch_out || SE);

endmodule
