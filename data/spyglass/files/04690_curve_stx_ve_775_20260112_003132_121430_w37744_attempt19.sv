module curve_stx_ve_775_20260112_003132_121430_w37744_attempt19 ();

  // STX_VE_775: Initial statement not allowed in this scope.
  // In Verilog-2001, 'initial' blocks are procedural and are not permitted
  // within a 'specify' block, which is used for timing and delay specifications.
  specify
    initial begin
      $display("ERROR: Initial block inside a specify block is disallowed.");
    end
  endspecify

endmodule
