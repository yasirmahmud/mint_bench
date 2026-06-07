module curve_stx_ve_520_20260110_145501_attempt1;

  // This macro definition uses a backslash for line continuation,
  // but it is immediately followed by an empty line before the string continues.
  // According to the context examples for STX_VE_520, this specific construction
  // where a backslash-newline for string continuation is followed by an empty line
  // often leads to an "Unterminated quoted string" violation by SpyGlass.
  // This typically triggers two violations: one at the end of the malformed string part
  // and another when the macro is instantiated, as its definition is corrupted.
  `define MALFORMED_STRING "This is the first part of the string \

  And this is the second part, which SpyGlass may not correctly associate."

  initial begin
    // Using the malformed string macro defined above.
    // This usage is expected to trigger a secondary STX_VE_520 violation
    // because the macro itself is ill-defined due to the empty line in its string literal.
    $display(`MALFORMED_STRING);
  end

endmodule
