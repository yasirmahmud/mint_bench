module curve_flopsrconst_20260111_040650_attempt2 (
  input wire clk,
  input wire d,
  output wire q
);

  // The original design explicitly tied the reset 'rst' high (assign rst = 1'b1;).
  // This meant the 'q' output was always reset to 1'b1, regardless of 'clk' or 'd'.
  // SpyGlass flagged this as a FlopSRConst violation because the flop's set pin
  // was constantly active, making the flop's output a constant value.
  // To preserve the functional behavior (q is always 1'b1) and resolve the violation,
  // the flop is removed and 'q' is directly assigned its constant value.
  assign q = 1'b1;

endmodule
