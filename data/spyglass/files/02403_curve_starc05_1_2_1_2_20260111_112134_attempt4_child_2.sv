module curve_starc05_1_2_1_2_20260111_112134_attempt4 (
  input S,
  input R,
  output Q_out
);

  reg internal_Q_reg;
  wire internal_Qbar;

  // This always block implements the behavior of an asynchronous RS latch.
  // For a NAND-based RS latch, the inputs S and R act as active-low SET and RESET respectively:
  // S=0: Sets Q_out to 1.
  // R=0: Resets Q_out to 0.
  // S=1, R=1: Holds the previous state of Q_out (latch inference).
  // The S=0, R=0 condition (typically considered invalid or race condition for NAND latches
  // where both Q and Qbar attempt to go high) is resolved by prioritizing the SET condition (S=0),
  // resulting in Q_out=1. This behavioral resolution is a common practice to avoid linting
  // violations associated with combinational loops and explicit primitive cell inference,
  // while preserving the core Set/Reset/Hold functional behavior of the RS latch.
  always @(S or R) begin
    if (S == 1'b0) begin // Active low SET
      internal_Q_reg = 1'b1;
    end else if (R == 1'b0) begin // Active low RESET
      internal_Q_reg = 1'b0;
    end
    // Else (S=1 and R=1), internal_Q_reg holds its value, inferring a latch.
  end

  assign internal_Qbar = ~internal_Q_reg; // The inverted output is derived from Q_out

  assign Q_out = internal_Q_reg;

endmodule
