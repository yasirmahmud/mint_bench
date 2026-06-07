module curve_warnanalyzebbox (
  input clk,
  input rst_n,
  input [7:0] data_in,
  output [7:0] data_out
);
  // This module has an empty body, meaning it defines an interface
  // but provides no internal logic. SpyGlass interprets such a design
  // unit as having an "empty definition" or a black box, triggering
  // the WarnAnalyzeBBox rule on the module itself.

endmodule
