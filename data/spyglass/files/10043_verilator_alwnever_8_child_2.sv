module example_8;
  reg [63:0] large_reg = 64'hDEADBEEF_CAFEBABE; // Resolves SYNTH_5143 by using synthesizable initialization.

  // The previous 'large_reg_read_dummy' declaration and assignment
  // were introduced to resolve a W528 on 'large_reg', but they created
  // a new W528 violation on 'large_reg_read_dummy' itself (as listed).
  // Removing them resolves the W528 on 'large_reg_read_dummy'.
  // If 'large_reg' is truly unused by other logic, it may still trigger
  // a 'set but not read' warning on 'large_reg' directly, but this is
  // not among the violations provided in the input JSON.

endmodule
