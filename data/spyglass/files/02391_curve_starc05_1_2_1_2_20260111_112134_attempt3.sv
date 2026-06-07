module curve_starc05_1_2_1_2_20260111_112134_attempt3 (
  input S,
  input R,
  output Q,
  output Qbar
);

  // This module implements a basic asynchronous RS latch using two cross-coupled NAND gates.
  // This structure is explicitly targeted by STARC05-1.2.1.2, which identifies
  // RS latches inferred using primitive cells. The rule reports on one of the latch outputs.
  // By using only primitive gates in a direct cross-coupled configuration, we aim to trigger
  // exactly one STARC05-1.2.1.2 violation and no other rules, specifically expecting a lint
  // tool to prioritize this latch inference rule over a generic combinational loop detection.

  nand nand_q (Q, S, Qbar);
  nand nand_qbar (Qbar, R, Q);

endmodule
