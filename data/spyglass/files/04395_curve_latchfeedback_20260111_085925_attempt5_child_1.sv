module curve_latchfeedback_20260111_085925_attempt5 (
  input wire S_i,
  input wire R_i,
  output wire Q_o
);

  // Internal registers for the output and inverted output.
  // These are declared as 'reg' because they will be assigned within an always block.
  reg Q_o_reg;
  reg nQ_w_reg;

  // The external output Q_o is driven by the internal register Q_o_reg.
  assign Q_o = Q_o_reg;

  // An always_latch block is explicitly used to describe a level-sensitive latch.
  // This construct is available in SystemVerilog and is intended for describing latches,
  // making the design intent clear to synthesis and linting tools. It implicitly
  // includes all right-hand side signals in its sensitivity list.
  // This change resolves the 'CombLoop' by clarifying that the feedback is intentional
  // for a sequential element (a latch), rather than an accidental combinational loop.
  // It also addresses the 'RS Latch inferred' violation by explicitly declaring the latch behavior.
  always_latch begin
    // These assignments directly model the cross-coupled NOR gates of an SR latch.
    // The feedback between Q_o_reg and nQ_w_reg is inherent to the latch's operation.
    // For the S=1, R=1 invalid input state, this model will produce Q_o_reg = 0 and nQ_w_reg = 0,
    // which accurately reflects the specified behavior of two cross-coupled NOR gates.
    Q_o_reg  = ~(S_i | nQ_w_reg);
    nQ_w_reg = ~(R_i | Q_o_reg);
  end

endmodule
