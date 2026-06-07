module W254_ex1(input clk, input data, input ref_event);
  // The specify block was removed as it is not synthesizable
  // and caused SYNTH_92 violations.
  // This module originally contained only a specify block,
  // which defines timing checks for simulation, not functional logic.

  // Dummy assignments to prevent W240 violations (inputs declared but not read).
  // These assignments do not alter any functional behavior,
  // as no functional behavior was defined in the original module body.
  wire _unused_clk = clk;
  wire _unused_data = data;
  wire _unused_ref_event = ref_event;
endmodule
