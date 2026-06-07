module curve_flopsrconst_20260111_223313_321972_w49296_attempt12 (
  input clk,
  input d,
  output q
);

  // As described, the reset is perpetually asserted, causing 'q' to always be 1'b0.
  // To resolve the FlopSRConst violation and reflect this constant behavior,
  // 'q' is directly assigned to 1'b0, eliminating the unresettable flip-flop.
  assign q = 1'b0;

endmodule
