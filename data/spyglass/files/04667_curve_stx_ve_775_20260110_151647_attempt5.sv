module curve_stx_ve_775_20260110_151647_attempt5 ();

  // STX_VE_775: Initial statement not allowed in this scope.
  // In Verilog-2001, 'initial' blocks are not allowed within a 'specify' block.
  // This placement is intended to trigger STX_VE_775. While typically a direct
  // syntax error (STX_VE_481), advanced linters like SpyGlass often provide
  // a more specific rule (STX_VE_775) when a known construct is incorrectly placed
  // in a context where it's parsed but semantically disallowed.
  specify
    initial begin // First occurrence of STX_VE_775
      $display("STX_VE_775 Violation 1: Initial block inside specify block.");
    end
  endspecify

  // To achieve a total count of 2 violations as requested, a second 'initial'
  // block is placed inside another 'specify' block.
  specify
    initial begin // Second occurrence of STX_VE_775
      $display("STX_VE_775 Violation 2: Another initial block inside specify block.");
    end
  endspecify

endmodule
