module curve_elab_6202_20260110_063939_attempt2 (
  output wire dummy_out
);

  // This initial block contains an infinite loop during simulation.
  // The ELAB_6202 rule targets infinite 'for' loops during the elaboration phase.
  initial begin
    integer i;
    // ELAB_6202: The loop condition 'i < 10' will always be true because 'i' never increments.
    // This creates an infinite loop during elaboration/simulation.
    for (i = 0; i < 10; i = i) begin : infinite_initial_loop
      // An empty block is allowed here and ensures no hardware is inferred from the loop itself.
    end
  end

  // Drive dummy_out to avoid unused port warnings or other synthesis rules.
  assign dummy_out = 1'b0;

endmodule
