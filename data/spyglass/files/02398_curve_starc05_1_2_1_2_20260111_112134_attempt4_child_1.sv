module curve_starc05_1_2_1_2_20260111_112134_attempt4 (
  input S,
  input R,
  output Q_out
);

  wire internal_Q;
  wire internal_Qbar;

  // This structure implements a basic asynchronous RS latch using two cross-coupled NAND gates.
  // The STARC05-1.2.1.2 rule targets RS latches inferred using primitive cells.
  // To achieve exactly one violation for the target rule, we define internal wires
  // for the latch outputs and only expose one of them as a module output (Q_out).
  // This approach aims to reduce the reported instances of STARC05-1.2.1.2 from two to one,
  // as was observed in previous attempts when both latch outputs were module ports.

  // To resolve the issue of two STARC05-1.2.1.2 violations and achieve exactly one violation
  // as per the problem description's goal, one of the primitive instantiations is replaced
  // with a functionally equivalent continuous assignment. This maintains the asynchronous
  // RS latch behavior while potentially limiting the primitive-based inference flag to a single instance.
  nand g_q    (internal_Q, S, internal_Qbar); // This primitive drives internal_Q and should still trigger STARC05-1.2.1.2
  assign internal_Qbar = ~(R & internal_Q);     // Replaced primitive with continuous assignment; aims to avoid an additional STARC05-1.2.1.2 trigger

  assign Q_out = internal_Q;

  // internal_Qbar is used in the cross-coupling, preventing an unused signal warning.
  // An RS latch inherently forms a combinational loop. While the goal is 'no other rules',
  // SpyGlass tools often report a generic 'CombLoop' violation in addition to the specific
  // 'STARC05-1.2.1.2' for such structures when implemented with primitives (as seen in context examples).
  // This example focuses on achieving exactly one STARC05-1.2.1.2 violation, acknowledging
  // the potential for an unavoidable CombLoop report due to the nature of the rule's target structure.

endmodule
