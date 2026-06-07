// This file is designed to trigger STX_VE_850 by having an unclosed `ifdef block.
// Define SOME_FLAG if not in a specific environment, to ensure the `ifdef block is active.
`ifndef SYNTHESIS
  `define SOME_FLAG
`endif

`ifdef SOME_FLAG
  // This `ifdef block is intentionally left unclosed. The missing `endif will cause
  // a "Premature end of source" error when the end of file is reached.

module curve_stx_ve_850_20260111_124711_attempt9 (
  input wire clk,
  output reg out_reg
);

  always @(posedge clk) begin
    out_reg <= clk;
  end

endmodule
