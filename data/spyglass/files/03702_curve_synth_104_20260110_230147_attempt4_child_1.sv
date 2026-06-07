module curve_synth_104_20260110_230147_attempt4 (
  input event_signal
);

  reg my_reg;

  // SYNTH_104: DEASSIGN statements are not synthesizable.
  always @(posedge event_signal) begin
    // The 'deassign my_reg;' statement is non-synthesizable and semantically
    // incorrect for a 'reg' that has not been subject to a procedural continuous assignment.
    // To resolve the SYNTH_104 violation and ensure synthesizable behavior for 'my_reg',
    // it is replaced with an explicit synchronous assignment. In the absence of
    // further functional description, assuming a synchronous clear/reset to 0
    // is the most common and robust interpretation for 'deactivating' or 'resetting'
    // a register in a clocked block.
    my_reg <= 1'b0;
  end

endmodule
