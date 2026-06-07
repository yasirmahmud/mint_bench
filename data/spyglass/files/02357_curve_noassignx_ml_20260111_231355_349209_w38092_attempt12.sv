module curve_noassignx_ml_20260111_231355_349209_w38092_attempt12 (
  output wire [1:0] data_out
);

  // This assign statement assigns a value containing 'x' on its RHS,
  // triggering the NoAssignX-ML rule.
  assign data_out = 2'b1x;

endmodule
