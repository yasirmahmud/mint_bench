module curve_stx_ve_520_20260110_145501_attempt4;

  // Occurrence 1: This macro definition contains a multi-line string literal
  // where a backslash at the end of the first line is followed by an empty line,
  // then the rest of the string. According to Verilog LRM (IEEE 1364-2001, section 2.2.3),
  // the backslash escapes the immediately following newline character. If an empty
  // line is present, the string effectively terminates before the empty line (or the
  // empty line and subsequent text are parsed incorrectly), leading SpyGlass to
  // report an "Unterminated quoted string" (STX_VE_520).
  `define MSG_1 "This is the first part of the string. The backslash indicates continuation, \
  
  but an empty line follows, causing the STX_VE_520 violation here."

  // Occurrence 2: A second macro definition using the identical problematic pattern
  // to generate the required total of 2 STX_VE_520 violations.
  `define MSG_2 "This is the second string, also designed to trigger STX_VE_520. \
  
  The intermediate empty line is the key for this violation."
  
  // These initial blocks use the defined macros to ensure they are parsed.
  // They should not introduce additional violations themselves, as the issue
  // lies within the macro definition syntax.
  initial begin
    $display("Verilog string issue example:");
    $display(`MSG_1);
    $display(`MSG_2);
  end

endmodule
