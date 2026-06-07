module jk_ms_ff  (Q, Qb, J, K, Clk, Set, Rst);

  
  input J,K,Clk,Rst,Set;
  output  Q,Qb;
  
  // Internal registers for master and slave latches
  reg MQ_internal, MQb_internal; // Master Latch outputs
  reg Q_internal, Qb_internal; // Slave Latch outputs

  // Master Latch (level-sensitive, transparent when Clk is high)
  // The master latch samples inputs (J, K) and the current state of the slave (Q_internal, Qb_internal)
  // when Clk is high. When Clk goes low, it holds its state.
  always @* begin
    // Default to hold state for the master latch (implied when no assignment is made within 'if (Clk)')
    // However, explicitly assigning here makes the latch inference more robust across tools.
    MQ_internal = MQ_internal;
    MQb_internal = MQb_internal;

    if (Clk) begin // Master Latch is transparent (active high)
      // Implement the JK logic for the master stage based on J, K and the slave's current state
      if (J == 1'b0 && K == 1'b0) begin
        // No change (hold state). Implicitly handled by default assignment if no other condition is met.
      end else if (J == 1'b0 && K == 1'b1) begin
        // Reset: MQ_internal becomes 0, MQb_internal becomes 1
        MQ_internal = 1'b0;
        MQb_internal = 1'b1;
      end else if (J == 1'b1 && K == 1'b0) begin
        // Set: MQ_internal becomes 1, MQb_internal becomes 0
        MQ_internal = 1'b1;
        MQb_internal = 1'b0;
      end else if (J == 1'b1 && K == 1'b1) begin
        // Toggle: MQ_internal becomes inverse of slave's Q_internal
        MQ_internal = ~Q_internal;
        MQb_internal = ~Qb_internal;
      end
    end
  end

  // Slave Latch (level-sensitive, transparent when Clkb is high, i.e., Clk is low)
  // It also incorporates asynchronous active-low Set and Reset inputs.
  // The final outputs Q and Qb update when Clk transitions from high to low (falling edge of Clk).
  always @* begin
    // Default to hold state for the slave latch
    Q_internal = Q_internal;
    Qb_internal = Qb_internal;

    // Asynchronous Set and Reset have highest priority
    if (Rst == 1'b0) begin // Active low Reset is dominant
      Q_internal = 1'b0;
      Qb_internal = 1'b1;
    end else if (Set == 1'b0) begin // Active low Set (lower priority than Rst)
      Q_internal = 1'b1;
      Qb_internal = 1'b0;
    end else if (Clk == 1'b0) begin // Slave Latch is transparent (active low Clk, or active high Clkb)
      // The slave latch copies the master's outputs
      Q_internal = MQ_internal;
      Qb_internal = MQb_internal;
    end
  end

  // Assign internal register outputs to the module's output ports
  assign Q = Q_internal;
  assign Qb = Qb_internal;
  
endmodule
