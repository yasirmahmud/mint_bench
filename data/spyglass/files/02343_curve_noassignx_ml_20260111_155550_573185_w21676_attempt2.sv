module curve_noassignx_ml_20260111_155550_573185_w21676_attempt2 (
  output out
);

  // Assigning 'x' directly to an output wire triggers the NoAssignX-ML violation.
  assign out = 1'bx;

endmodule
