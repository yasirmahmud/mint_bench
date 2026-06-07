module curve_noassignx_ml_20260111_155550_573185_w21676_attempt4 (
  output out
);

  // A continuous assignment of '1'bx' on the RHS triggers NoAssignX-ML.
  // This avoids the 'initial' block synthesis warning from the previous attempt.
  assign out = 1'bx;

endmodule
