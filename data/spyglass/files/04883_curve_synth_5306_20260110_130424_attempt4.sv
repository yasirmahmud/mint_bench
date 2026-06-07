module curve_synth_5306_20260110_130424_attempt4 (
  input wire clk,
  output reg out_data
);

  reg internal_reg; // Internal register to ensure signals are used and for sequential logic

  // This is a named sequential block, 'my_target_block'.
  // It implements a simple D-flip-flop chain and ensures 'out_data' is driven and 'clk' is used.
  always @(posedge clk) begin : my_target_block
    internal_reg <= clk;
    out_data <= internal_reg;
  end

  // This `initial` block contains the `disable` statement. Initial blocks are typically
  // ignored by synthesis tools for gate generation, which we hope will prevent the broader
  // 'ErrorAnalyzeBBox' violation that occurred in previous attempts.
  // However, `SYNTH_5306` (Named task or block is not in scope of disable statement) is often
  // an elaboration or linting type check that can still be reported even if the code is 
  // not synthesized.
  // The `disable` statement attempts to target 'my_target_block'. In SpyGlass's interpretation
  // for `SYNTH_5306`, a sibling `always` block (like 'my_target_block' in relation to the
  // 'initial' block) is considered "not in scope" for a `disable` statement.
  initial begin : my_disabler_initial_block
    disable my_target_block; // This is expected to trigger SYNTH_5306
  end

endmodule
