module curve_synth_5059_20260110_122446_attempt4 (
  output out_neq
);

  // SYNTH_5059: Case inequality (!==) encountered which is not supported by synthesis.
  // Using the case inequality operator (!==) within a localparam constant expression
  // is intended to trigger SYNTH_5059 because synthesis tools must process this expression
  // but generally do not support X/Z comparisons in hardware. This specific context
  // might avoid the co-triggering of W339a if W339a is more narrowly defined for
  // direct hardware description logic (e.g., in always blocks or assign statements).
  localparam IS_NEQ_CONST = (4'b00xx !== 4'b00zz);

  // Drive the output with the constant to avoid unused signal warnings.
  assign out_neq = IS_NEQ_CONST;

endmodule
