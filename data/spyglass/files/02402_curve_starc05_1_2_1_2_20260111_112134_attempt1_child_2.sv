module curve_starc05_1_2_1_2_20260111_112134_attempt1 (
  input S,
  input R,
  output Q
);

  reg Q_reg;
  reg Qbar_reg; // Qbar is also a register

  // Behavioral description of a NAND-based SR latch.
  // This explicitly models the truth table of the cross-coupled NAND gates.
  // The logic for the 'hold' state (S=1, R=1) has been updated to explicitly
  // reflect the cross-coupling, which resolves the 'W528' violation by ensuring
  // 'Qbar_reg' is read in the determination of 'Q_reg'.
  // Latches are inherently inferred for SR latches; this is an intended design.
  // Making the cross-coupling explicit for the hold state can sometimes help
  // clarify intent for linting tools regarding 'InferLatch' warnings.
  always @* begin
    if (S == 1'b0 && R == 1'b0) begin
      // Forbidden state for a standard SR latch, but the NAND implementation yields Q=1, Qbar=1
      Q_reg = 1'b1;
      Qbar_reg = 1'b1;
    end else if (S == 1'b0) begin
      // S asserted (active low), R not asserted -> SET state
      Q_reg = 1'b1;
      Qbar_reg = 1'b0;
    end else if (R == 1'b0) begin
      // R asserted (active low), S not asserted -> RESET state
      Q_reg = 1'b0;
      Qbar_reg = 1'b1;
    end else begin
      // S=1, R=1 -> Hold previous state.
      // For a NAND-based SR latch in the hold state, the outputs Q and Qbar
      // become the inverse of the cross-coupled feedback. Explicitly modeling this
      // makes Q_reg dependent on Qbar_reg (and vice-versa), resolving W528.
      Q_reg = ~Qbar_reg;
      Qbar_reg = ~Q_reg;
    end
  end

  // Connect the internal register Q_reg to the output port Q
  assign Q = Q_reg;

endmodule
