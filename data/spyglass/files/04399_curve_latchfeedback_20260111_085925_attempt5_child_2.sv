module curve_latchfeedback_20260111_085925_attempt5 (
  input wire S_i,
  input wire R_i,
  output wire Q_o
);

  // Internal wires for the output and inverted output.
  // These are declared as 'wire' because they will be driven by continuous assignments (gate instantiations).
  wire Q_o_w;
  wire nQ_w;

  // The external output Q_o is driven by the internal wire Q_o_w.
  assign Q_o = Q_o_w;

  // Explicitly instantiate NOR gates to describe the SR latch's cross-coupled structure.
  // This gate-level description clarifies the design intent as an intentional sequential
  // element (a level-sensitive latch) and is often more robust against linting violations
  // related to combinational loops and inferred latches compared to behavioral descriptions.
  // By using explicit `nor` primitives, the tool is less likely to flag an "inferred latch"
  // or an unintended "combinational loop" and resolves the `always_latch` mismatch error.
  // This accurately models the specified behavior of two cross-coupled NOR gates.
  nor N1 (Q_o_w, S_i, nQ_w);
  nor N2 (nQ_w, R_i, Q_o_w);

endmodule
