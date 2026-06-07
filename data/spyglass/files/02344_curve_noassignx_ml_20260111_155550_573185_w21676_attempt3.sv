module curve_noassignx_ml_20260111_155550_573185_w21676_attempt3 (
  output reg out
);

  // Assigning 'x' during initialization in an initial block triggers NoAssignX-ML.
  initial begin
    out = 1'bx;
  end

endmodule
