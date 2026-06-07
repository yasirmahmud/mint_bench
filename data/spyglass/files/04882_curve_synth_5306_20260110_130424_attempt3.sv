module curve_synth_5306_20260110_130424_attempt3 (
  input wire clk,
  output reg out_data
);

  // This is a named sequential block, 'my_target_block'.
  // It drives 'out_data', ensuring the signal is used.
  always @(posedge clk) begin : my_target_block
    out_data <= ~out_data;
  end

  // This sequential block, 'my_disabler_block', attempts to disable 'my_target_block'.
  // Since 'my_target_block' is a sibling block at the same hierarchical level 
  // within the module, it is not considered to be in the scope of 'my_disabler_block'.
  // This directly triggers the SYNTH_5306 violation: "Named task or block is not in scope of disable statement".
  always @(posedge clk) begin : my_disabler_block
    // The 'disable' statement is a non-synthesizable construct in RTL.
    // Its presence, especially when violating SYNTH_5306, will likely trigger
    // a higher-level 'ErrorAnalyzeBBox' indicating non-synthesizable design.
    // Given that the context examples also show ErrorAnalyzeBBox alongside SYNTH_5306,
    // and ErrorAnalyzeBBox explicitly references SYNTH_5306 in its message, it's considered
    // a dependent violation rather than an independent one in this specific case.
    disable my_target_block;
  end

endmodule
