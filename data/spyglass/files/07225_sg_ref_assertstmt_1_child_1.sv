module assert_stmt_ex1();
  // Original Verilog:
  // initial begin assert(1); end
  //
  // SpyGlass violation SYNTH_5143: "Initial block is ignored for synthesis"
  //
  // Resolution:
  // The 'initial' block is inherently a simulation-only construct and is ignored by synthesis tools.
  // The 'assert(1)' statement within it means that at time 0, a check for 'true' is performed,
  // which always passes. Since the 'initial' block's contents have no functional impact on the
  // synthesized design and 'assert(1)' trivially passes in simulation, the most direct way to
  // resolve the SYNTH_5143 violation while preserving functional behavior (in terms of no assertion
  // failures) is to remove the non-synthesizable 'initial' block and its contents.
  // This resolves the synthesis warning without altering the module's interface or introducing
  // new functional behavior relevant to hardware.
endmodule
