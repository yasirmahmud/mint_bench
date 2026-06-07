module curve_flopsrconst_20260111_184819_104583_w7792_attempt8 (
  input clk,
  input d,
  output q
);

  // As per the design description, the reset pin is always active,
  // causing the 'q' output to be always reset to 1'b0.
  // To maintain this functional behavior and resolve the FlopSRConst violation,
  // 'q' is directly tied to 1'b0, eliminating the redundant flop.
  assign q = 1'b0;

endmodule
