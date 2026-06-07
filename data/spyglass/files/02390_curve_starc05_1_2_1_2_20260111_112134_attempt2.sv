module curve_starc05_1_2_1_2_20260111_112134_attempt2 (
  input S,
  input R,
  output Q
);

  wire Qbar_feedback;

  // An RS latch formed by one primitive cell and a continuous assignment.
  // This attempts to trigger the STARC05-1.2.1.2 rule for 'Q' as inferred
  // by the explicit primitive, and potentially avoid a second violation
  // for 'Qbar_feedback' which is defined by an assign statement rather
  // than a direct primitive instantiation.
  // A combinational loop is inherent to an RS latch and may still be flagged.
  nand nand_q_gate (Q, S, Qbar_feedback);
  assign Qbar_feedback = ~(R & Q);

endmodule
