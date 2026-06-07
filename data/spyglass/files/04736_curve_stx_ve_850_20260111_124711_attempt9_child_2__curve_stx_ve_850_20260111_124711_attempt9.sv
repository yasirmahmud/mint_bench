// This file is designed to trigger STX_VE_850 by having an unclosed `ifdef block.
// Define SOME_FLAG if not in a specific environment, to ensure the `ifdef block is active.
// The `ifndef SYNTHESIS block around `define SOME_FLAG is removed to ensure SOME_FLAG is always defined,
// allowing the module to be visible to the linter and resolving the NoTopDUFound violation.
`define SOME_FLAG // Ensure SOME_FLAG is always defined for linting

`ifdef SOME_FLAG
  // This `ifdef block was intentionally left unclosed. The missing `endif caused
  // a "Premature end of source" error when the end of file was reached. Adding `endif to fix.

module curve_stx_ve_850_20260111_124711_attempt9 (
  input wire clk,
  output reg out_reg
);

  always @(posedge clk) begin
    out_reg <= clk;
  end

endmodule
