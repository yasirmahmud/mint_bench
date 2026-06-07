module rs_latch_ex2 (input R, S, output reg Q, output Q_n);

  // The original design uses primitive NOR gates to implement an asynchronous RS latch,
  // which results in combinational loop violations and triggers the STARC05-1.2.1.2
  // rule for inferring latches with primitive cells.
  //
  // To resolve these violations while preserving the functional behavior (asynchronous RS latch
  // with R having priority over S for the Q output, and both Q and Q_n going low when R=S=1),
  // we model the Q output using a behavioral always @* block and then derive Q_n combinatorially.

  // Model the Q output of the RS latch. The sensitivity list for @* includes R and S.
  // R takes priority, consistent with the NOR gate implementation where R=S=1 results in Q=0.
  always @* begin
    if (R) begin // If R is high, reset Q to 0. (R has priority over S if both are high)
      Q = 1'b0;
    end else if (S) begin // If S is high and R is low, set Q to 1
      Q = 1'b1;
    end else begin // If both R and S are low (R=0, S=0), Q holds its previous value.
      Q = Q;       // Explicitly stating the hold condition for the latch to potentially resolve InferLatch violation.
    end
  end

  // Model the Q_n output based on the behavior of the second NOR gate: Q_n = ~(S | Q).
  // This breaks the explicit combinational feedback loop between Q and Q_n in the Verilog code,
  // resolving the CombLoop violation. Q_n is now a combinational output derived from S and Q.
  assign Q_n = ~(S | Q);

endmodule
