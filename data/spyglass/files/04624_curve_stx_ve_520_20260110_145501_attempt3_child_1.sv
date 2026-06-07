module curve_stx_ve_520_20260110_145501_attempt3;

  // First occurrence: A macro definition containing a multi-line string literal.
  // According to Verilog-2001 (IEEE 1364-2001, section 2.2.3), if a string
  // is continued on multiple lines, both the end of the preceding line
  // and the beginning of the continued line must have a backslash.
  // Here, the first line ends with a backslash for continuation, but the
  // second line does NOT start with a backslash. SpyGlass interprets this
  // incorrect multi-line string continuation syntax as an "unterminated quoted string",
  // even though a closing quote eventually appears on the next line.
  `define BAD_STRING_1 "This is the first string part that ends with a backslash for continuation, \
\  but the next line does not properly start with a backslash."

  initial begin
    $display(`BAD_STRING_1);
  end

  // Second occurrence: Another macro following the identical pattern
  // to generate the required second STX_VE_520 violation.
  `define BAD_STRING_2 "This is the second string part that ends with a backslash for continuation, \
\  and this also misses the leading backslash on the next line."
  
  initial begin
    $display(`BAD_STRING_2);
  end

endmodule
