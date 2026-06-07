module curve_synth_5188_20260110_173530_attempt11 (
  input clk,
  input rst_n,
  input [1:0] data_in,
  output reg [1:0] data_out
);

  // Target rule: SYNTH_5188
  // Rule description: Invalid placement of event control statement inside asynchronous implicit style always block. Not supported.
  // This module is crafted to specifically trigger SYNTH_5188, based on the provided successful context example.
  // The key elements are:
  // 1. An 'always' block with an asynchronous sensitivity list (e.g., posedge clk or negedge rst_n).
  // 2. An event control statement (@(posedge clk)) placed directly on the RHS of a non-blocking assignment
  //    within this asynchronous 'always' block.
  // To avoid triggering SYNTH_5317 (as observed in previous attempts), this example replicates the exact
  // structural style of the reference example, specifically using single-line if/else branches without
  // explicit 'begin...end' keywords when only one statement is present in the branch. This distinction
  // is critical based on the rule firing behavior of the provided context example.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) data_out <= 2'b0; // Asynchronous reset
    else data_out <= @(posedge clk) data_in; // SYNTH_5188 violation expected here at line 17
  end

endmodule
