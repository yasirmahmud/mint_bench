module w309_ex1;
  reg r = 1'b0; // Initialized 'r' to resolve W123 violation.
  // Variable 'i' and the 'initial' block were removed as they caused W528 (set but not read)
  // and SYNTH_5143 (initial block ignored for synthesis) violations, respectively.
  // This change maintains the module's functional behavior by removing unused and non-synthesizable constructs.
endmodule
