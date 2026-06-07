module child_module (input rst, output dummy_out);
  // Original: W240 (rst not read), WarnAnalyzeBBox (empty module)
  // Current (from problem): W528 (unused_rst_sink set but not read)
  // Solution: Add a dummy output to 'read' the 'rst' input, resolving W240.
  // This also resolves WarnAnalyzeBBox as the module is no longer empty.
  // And it removes the need for 'unused_rst_sink', thus resolving W528.
  assign dummy_out = rst;
endmodule
