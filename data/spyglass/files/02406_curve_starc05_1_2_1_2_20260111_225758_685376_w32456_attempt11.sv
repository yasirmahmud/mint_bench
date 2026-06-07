module curve_starc05_1_2_1_2_20260111_225758_685376_w32456_attempt11 (
  input s_in,
  input r_in,
  output q_out,
  output qn_out
);

  // Internal wires for the cross-coupled gates forming the latch
  wire q_internal;
  wire qn_internal;

  // This pair of cross-coupled NOR gates forms an active-high RS latch.
  // This structure is specifically designed to trigger STARC05-1.2.1.2.
  // The rule detects RS latches inferred from primitive cells. Each such
  // inferred latch is intended to count as a single violation instance.
  nor gate_nor_q (q_internal, s_in, qn_internal);
  nor gate_nor_qn (qn_internal, r_in, q_internal);

  // Expose the Q and QN outputs of the latch
  assign q_out = q_internal;
  assign qn_out = qn_internal;

endmodule
