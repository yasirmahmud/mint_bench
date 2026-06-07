module child_module (input rst);
  // Resolve W240: Input 'rst' declared but not read.
  // Resolve WarnAnalyzeBBox: Design Unit 'child_module' has empty definition
  wire unused_rst_sink;
  assign unused_rst_sink = rst;
 endmodule
