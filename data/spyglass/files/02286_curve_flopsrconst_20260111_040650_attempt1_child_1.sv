module curve_flopsrconst_20260111_040650_attempt1 (
  input wire clk,
  input wire d,
  output wire q
);

  // The original design had its active-low reset (rst_n) tied to 1'b0,
  // meaning the flop 'q' was perpetually in its reset state (q <= 1'b0).
  // To preserve this functional behavior (q always 0) and remove the
  // FlopSRConst violation (which indicates a flop with a redundant or
  // constantly asserted set/reset), the flop is replaced with a direct
  // continuous assignment of 0 to 'q'.
  assign q = 1'b0;

endmodule
