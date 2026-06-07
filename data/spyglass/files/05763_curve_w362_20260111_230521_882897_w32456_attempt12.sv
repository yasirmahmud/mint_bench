module curve_w362_20260111_230521_882897_w32456_attempt12 (
  input [7:0] current_level,
  input [31:0] upper_bound,
  output wire level_exceeded
);

  // W362 violation expected: For operator (>), left expression width 8 should mismatch right expression width 32
  assign level_exceeded = (current_level > upper_bound);

endmodule
