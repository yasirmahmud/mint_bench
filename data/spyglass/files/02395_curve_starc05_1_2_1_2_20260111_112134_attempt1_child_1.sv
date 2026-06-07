module curve_starc05_1_2_1_2_20260111_112134_attempt1 (
  input S,
  input R,
  output Q
);

  reg Q_reg;    // Q is now a register to implement the latch
  reg Qbar_reg; // Qbar is also a register

  // Behavioral description of a NAND-based SR latch
  // This explicitly models the truth table of the cross-coupled NAND gates.
  // Using an 'always @*' block (SystemVerilog) or 'always @(S or R or Q_reg or Qbar_reg)' (Verilog-2001)
  // resolves the STARC05-1.2.1.2 violation by avoiding primitive cells.
  // This behavioral description of a latch is generally recognized by synthesis tools,
  // which may mitigate or resolve the CombLoop violation, as it describes an intended sequential element.
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
      // By not assigning Q_reg and Qbar_reg in this branch, a latch is implicitly inferred.
    end
  end

  // Connect the internal register Q_reg to the output port Q
  assign Q = Q_reg;

endmodule
