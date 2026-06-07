module curve_stx_ve_350_20260110_143444_attempt5 (
  input signal_a,
  output reg signal_b
);

  integer counter_i; // An integer variable, not a task or block

  initial begin
    // STX_VE_350 violation 1: Attempting to disable an 'integer' variable.
    // 'counter_i' is not a task, function, or named procedural block.
    disable counter_i;
    signal_b = 1'b0; // Initialize output to avoid X-propagation
  end

  always @(signal_a) begin : some_procedural_block
    // STX_VE_350 violation 2: Attempting to disable an input port.
    // 'signal_a' is not a task, function, or named procedural block.
    disable signal_a;
    signal_b = signal_a; // Dummy logic to avoid 'signal_a' being unused
  end

endmodule
