module curve_w362_20260111_230521_882897_w32456_attempt11 (
  input [7:0] data_val,
  input [31:0] limit_val,
  output wire is_exceeded
);

  // W362 violation expected: For operator (>), left expression width 8 should mismatch right expression width 32
  assign is_exceeded = (data_val > limit_val);

endmodule
