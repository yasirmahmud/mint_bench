module curve_synth_5306_20260110_130424_attempt5 (
  input wire clk,
  input wire reset_n,
  input wire trigger,
  output reg out_data
);

  reg internal_reg; // Internal register to ensure signals are used

  // This is a named sequential block, 'my_target_block'.
  // It describes a simple D-flip-flop chain and ensures 'out_data' is driven.
  // This block is intended to be the target of the 'disable' statement.
  always @(posedge clk or negedge reset_n) begin : my_target_block
    if (!reset_n) begin
      internal_reg <= 1'b0;
      out_data <= 1'b0;
    end else begin
      internal_reg <= trigger; // Use 'trigger' to ensure 'internal_reg' is actively driven
      out_data <= internal_reg;
    end
  end

  // This 'always' block contains the 'disable' statement.
  // In Verilog-2001, a named 'always' block (like 'my_target_block') and another
  // 'always' block (like this one) are considered sibling scopes if declared at the same level.
  // A 'disable' statement from one sibling scope trying to disable another sibling scope
  // is generally considered "not in scope" by linting tools like SpyGlass for SYNTH_5306.
  always @(posedge clk) begin : my_disabler_block
    if (trigger) begin // The condition ensures the disable is not always active
      disable my_target_block; // This is specifically expected to trigger SYNTH_5306
    end
  end

endmodule
