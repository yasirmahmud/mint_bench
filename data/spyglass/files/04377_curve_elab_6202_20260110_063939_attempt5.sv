module curve_elab_6202_20260110_063939_attempt5 (
  output wire dummy_out
);

  integer i; // Declare loop variable as integer for procedural block

  initial begin : infinite_sim_loop
    // ELAB_6202: This procedural 'for' loop is designed to be infinite.
    // The loop variable 'i' starts at 0. The condition 'i < 10' is initially true.
    // The update expression 'i = i' means 'i' never changes from its initial value.
    // This creates an infinite loop during elaboration and simulation, as the condition
    // 'i < 10' always remains true. Since this is inside an 'initial' block,
    // synthesis tools are expected to ignore its content for hardware generation,
    // thereby avoiding synthesis-specific errors (like SYNTH_5230 from previous attempts)
    // that are typically triggered by structural 'generate for' loops.
    for (i = 0; i < 10; i = i) begin
      // An empty block is sufficient to demonstrate the infinite loop behavior
      // without introducing any synthesizable logic or additional warnings.
    end
  end

  // Drive dummy_out to avoid unused port warnings.
  assign dummy_out = 1'b0;

endmodule
