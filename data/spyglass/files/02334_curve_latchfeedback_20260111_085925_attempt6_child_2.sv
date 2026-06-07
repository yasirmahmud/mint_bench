module curve_latchfeedback_20260111_085925_attempt6 (
  input wire enable,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // Internal register for the master latch. This latch captures the next value
  // to be stored in 'data_out'. It is enabled when 'enable' is low.
  reg [7:0] master_latch_q;

  // Master Latch and Summation Logic:
  // This block serves two purposes:
  // 1. It calculates the sum (data_out + data_in) using the *stable* value of 'data_out'.
  //    The 'data_out' on the right-hand side here refers to the held value of the slave latch
  //    when 'enable' is low (i.e., when 'data_out' is not transparently updating).
  // 2. It infers a level-sensitive latch for 'master_latch_q'.
  //    When 'enable' is low, 'master_latch_q' is transparent and updates with the calculated sum.
  //    When 'enable' is high, 'master_latch_q' closes and holds its value. This breaks the
  //    combinational feedback loop that caused the LatchFeedback violation by ensuring
  //    that the value fed to the slave latch is stable during the slave latch's transparent phase.
  always @(enable or data_in or data_out) begin
    if (!enable) begin // Master latch is active when enable is low
      master_latch_q = data_out + data_in;
    end
    // The 'else' branch is intentionally omitted to infer a latch for 'master_latch_q'.
  end

  // Slave Latch:
  // This block infers the main output latch ('data_out').
  // When 'enable' is high, this latch is transparent, passing the stable value from 'master_latch_q'.
  // When 'enable' is low, this latch closes and holds its value.
  // This master-slave configuration, with latches enabled on opposite phases of 'enable',
  // effectively creates an edge-triggered behavior (similar to a flip-flop) using two level-sensitive latches.
  // This resolves the LatchFeedback and STARC05-2.4.1.5 violations by providing a clean, stable
  // data path without combinational feedback races and avoiding same-phase multi-level latching.
  always @(enable or master_latch_q) begin
    if (enable) begin // Slave latch is active when enable is high
      data_out = master_latch_q;
    end
    // The 'else' branch is intentionally omitted to infer a latch for 'data_out'.
  end

endmodule
