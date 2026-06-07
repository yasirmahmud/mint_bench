module curve_stx_ve_350_20260110_143444_attempt5 (
  input signal_a,
  output reg signal_b
);

  integer counter_i; // An integer variable, not a task or block

  initial begin
    // Removed 'disable counter_i;' as it was attempting to disable an integer variable,
    // which is not a valid target for the 'disable' keyword (STX_VE_350 violation).
    signal_b = 1'b0; // Initialize output to avoid X-propagation
  end

  always @(signal_a) begin : some_procedural_block
    // Removed 'disable signal_a;' as it was attempting to disable an input port,
    // which is not a valid target for the 'disable' keyword (STX_VE_350 violation).
    signal_b = signal_a; // Dummy logic to avoid 'signal_a' being unused
  end

endmodule
