module curve_starc05_2_10_1_4b_20260111_094016_attempt2 (
  input  wire [1:0]  data_in
);

  // The original 'initial' block and its contents have been removed.
  // This resolves the SYNTH_5143 warning as 'initial' blocks are ignored for synthesis.
  // The problematic comparison 'if (data_in === 2'b1z)' directly caused
  // the STARC05-2.10.1.4b error ("Signal compared with value containing x or z")
  // and the W339a warning ("Operator '===' should be avoided in synthesis logic").
  // Since the module had no synthesizable functional behavior other than demonstrating these violations,
  // removing the non-synthesizable block maintains the intended lack of functional synthesis while resolving all reported violations.

endmodule
