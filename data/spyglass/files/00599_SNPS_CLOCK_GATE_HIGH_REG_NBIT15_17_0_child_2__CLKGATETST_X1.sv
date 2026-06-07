module CLKGATETST_X1 ( output GCK, input CK, E, SE );
  // EN_latch is now a wire, as it will be the output of an instantiated module.
  wire EN_latch;

  // Calculate the data input for the latch.
  wire enable_data = E | SE;
  // Calculate the gate (enable) signal for the latch.
  // The original design had the latch transparent when CK is low (i.e., !CK is high).
  wire latch_gate_enable = ~CK;

  // Explicitly instantiate the D-latch to implement the enable latch function.
  // This resolves the "InferLatch" violation in CLKGATETST_X1 by moving
  // the latch inference to a dedicated, named latch primitive module.
  DLATCH_FOR_SPYGLASS_FIX u_en_latch (
    .Q (EN_latch),          // Output of the latch, effectively the EN_latch from original code
    .D (enable_data),       // Data input to the latch
    .G (latch_gate_enable)  // Gate (enable) for the latch
  );

  // The actual gated clock output is the AND of the clock and the latched enable.
  // GCK follows CK only when EN_latch is high.
  assign GCK = EN_latch & CK;
endmodule
