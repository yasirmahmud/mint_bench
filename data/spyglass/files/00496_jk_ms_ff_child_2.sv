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
    // Use temporary variables for the next state to explicitly model the latching behavior.
    // This ensures all execution paths assign a value to 'next_MQ_internal'/'next_MQb_internal',
    // then that value is unconditionally assigned to 'MQ_internal'/'MQb_internal' at the end of the block.
    // This commonly helps satisfy linting rules regarding inferred latches by making the assignments more explicit.
    reg next_MQ_internal;
    reg next_MQb_internal;

    // Default to holding the current state of the master latch.
    // This defines the latch's 'hold' behavior when not enabled or not actively changing.
    next_MQ_internal = MQ_internal;
    next_MQb_internal = MQb_internal;

    if (Clk) begin // Master Latch is transparent (active high)
      // Implement the JK logic for the master stage based on J, K and the slave's current state
      if (J == 1'b0 && K == 1'b0) begin
        // No change (hold state). 'next_MQ_internal' retains its defaulted value (MQ_internal).
      end else if (J == 1'b0 && K == 1'b1) begin
        // Reset: MQ_internal becomes 0, MQb_internal becomes 1
        next_MQ_internal = 1'b0;
        next_MQb_internal = 1'b1;
      end else if (J == 1'b1 && K == 1'b0) begin
        // Set: MQ_internal becomes 1, MQb_internal becomes 0
        next_MQ_internal = 1'b1;
        next_MQb_internal = 1'b0;
      end else if (J == 1'b1 && K == 1'b1) begin
        // Toggle: MQ_internal becomes inverse of slave's Q_internal
        next_MQ_internal = ~Q_internal;
        next_MQb_internal = ~Qb_internal;
      end
    end
    // Assign the computed next state to the actual master latch registers.
    // This assignment happens unconditionally at the end of the always @* block.
    MQ_internal = next_MQ_internal;
    MQb_internal = next_MQb_internal;
  end

  // Slave Latch (level-sensitive, transparent when Clkb is high, i.e., Clk is low)
  // It also incorporates asynchronous active-low Set and Reset inputs.
  // The final outputs Q and Qb update when Clk transitions from high to low (falling edge of Clk).
  always @* begin
    // Use temporary variables for the next state to explicitly model the latching behavior.
    reg next_Q_internal;
    reg next_Qb_internal;

    // Default to holding the current state of the slave latch.
    next_Q_internal = Q_internal;
    next_Qb_internal = Qb_internal;

    // Asynchronous Set and Reset have highest priority
    if (Rst == 1'b0) begin // Active low Reset is dominant
      next_Q_internal = 1'b0;
      next_Qb_internal = 1'b1;
    end else if (Set == 1'b0) begin // Active low Set (lower priority than Rst)
      next_Q_internal = 1'b1;
      next_Qb_internal = 1'b0;
    end else if (Clk == 1'b0) begin // Slave Latch is transparent (active low Clk, or active high Clkb)
      // The slave latch copies the master's outputs
      next_Q_internal = MQ_internal;
      next_Qb_internal = MQb_internal;
    end
    // Assign the computed next state to the actual slave latch registers.
    Q_internal = next_Q_internal;
    Qb_internal = next_Qb_internal;
  end

  // Assign internal register outputs to the module's output ports
  assign Q = Q_internal;
  assign Qb = Qb_internal;
  
endmodule
