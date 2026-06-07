module curve_flopsrconst_20260111_223313_321972_w49296_attempt11 (
  input clk,
  input d,
  output reg q
);

  // The original design tied the asynchronous active-low reset 'rst_n' to a constant 1'b0.
  // This meant the flip-flop 'q' was always in its reset state (1'b0),
  // preventing the data path from ever being active. The SpyGlass FlopSRConst
  // violation correctly identified this redundant logic.
  // 
  // To preserve the intended functional behavior (q always being 1'b0)
  // while resolving the linting violation, the flip-flop logic is replaced
  // with a direct assignment of 'q' to its constant reset value.
  assign q = 1'b0; 

endmodule
