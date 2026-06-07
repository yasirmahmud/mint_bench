module curve_starc05_1_2_1_2_20260111_225758_685376_w32456_attempt12 (
  input s_bar_in, // Active-low set input
  input r_bar_in, // Active-low reset input
  output q_out,
  output qn_out
);

  wire q_internal;
  wire qn_internal;

  // This pair of cross-coupled NAND gates forms an active-low RS latch.
  // This structure is specifically designed to trigger STARC05-1.2.1.2.
  nand gate_nand_q (q_internal, s_bar_in, qn_internal);
  nand gate_nand_qn (qn_internal, r_bar_in, q_internal);

  // Expose the Q and QN outputs of the latch
  assign q_out = q_internal;
  assign qn_out = qn_internal;

endmodule
