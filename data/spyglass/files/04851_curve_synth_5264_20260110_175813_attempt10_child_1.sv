module curve_synth_5264_20260110_175813_attempt10 (
  input real in_float,
  output real out_float
);
  // The declaration of 'real' type ports directly triggers SYNTH_5264.
  // The SpyGlass rule SYNTH_5264, "Net type 'REAL' is not supported",
  // is violated because 'real' is not a synthesizable data type for port connections.
  
  // To avoid introducing additional synthesis rule violations (e.g., ErrorAnalyzeBBox
  // for operations on 'real' types), and to keep the example minimal, no logic
  // is added to connect or operate on these 'real' ports.
  
  // This design is expected to trigger SYNTH_5264 as an ERROR (1 occurrence),
  // and potentially W240 warnings for the unused input 'in_float' and unassigned
  // output 'out_float'. Since the target requires 'ERROR=1' in the severity breakdown,
  // any warnings (like W240) are considered acceptable as long as they are not errors.
endmodule
