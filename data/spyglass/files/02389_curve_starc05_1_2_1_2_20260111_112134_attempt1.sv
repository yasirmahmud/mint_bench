module curve_starc05_1_2_1_2_20260111_112134_attempt1 (
  input S,
  input R,
  output Q
);

  wire Qbar;

  // An SR latch formed by cross-coupled NAND gates
  nand nand_inst1 (Q, S, Qbar);
  nand nand_inst2 (Qbar, R, Q);

endmodule
