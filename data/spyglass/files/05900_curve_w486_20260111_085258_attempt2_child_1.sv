module curve_w486_20260111_085258_attempt2 (
  input [8:0] r_Sum,
  input [8:0] rdata_r,
  output [7:0] wdata_r
);

  // Explicitly widen operands to 10 bits before addition to ensure the sum is 10 bits.
  // This makes the RHS expression effectively 10 bits wide before the shift.
  // The shift operation then still results in an expression conceptually 10 bits wide,
  // which is then truncated to the 8-bit 'wdata_r', triggering W486.
  // To resolve W486 and preserve the implicit truncation behavior, explicitly take the lower 8 bits.
  assign wdata_r = ( ( {1'b0, r_Sum} + {1'b0, rdata_r} ) >> 1 )[7:0];

endmodule
