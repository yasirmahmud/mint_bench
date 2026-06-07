module curve_latchfeedback_20260111_085925_attempt5 (
  input wire S_i,
  input wire R_i,
  output wire Q_o
);

  // Internal wire for the inverted output (nQ)
  wire nQ_w;

  // These two continuous assignments create a cross-coupled feedback loop,
  // explicitly forming a NOR-based SR latch. This structure inherently
  // involves feedback and is prone to race conditions (e.g., when S_i and R_i
  // are both asserted simultaneously or change at the same time).
  // This constitutes a potential feedback race for the latch Q_o.
  assign Q_o = ~(S_i | nQ_w);
  assign nQ_w = ~(R_i | Q_o);

endmodule
