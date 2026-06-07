module curve_starc05_1_2_1_2_20260111_193735_888802_w7792_attempt10 (
  input wire s_bar_in,  // Active-low Set input
  input wire r_bar_in,  // Active-low Reset input
  output wire q_out     // Main output
);

  wire q_internal;
  wire qn_internal; // Complementary output, used for feedback

  // This pair of cross-coupled NAND gates forms an active-low RS latch.
  // This structure is expected to trigger the STARC05-1.2.1.2 rule.
  // The line numbers for the reports typically point to the primitive instantiations.
  nand gate_nand_q (q_internal, s_bar_in, qn_internal);
  nand gate_nand_qn (qn_internal, r_bar_in, q_internal);

  assign q_out = q_internal; // Expose only the Q output

endmodule
