module W189_ex1();
  // SpyGlass W189 rule indicates lines ignored by 'translate_off' are not part of the design.
  // The original code had nested translate_off directives with an unmatched translate_on,
  // and also commented out the 'endmodule' statement, leading to syntax errors.
  // This correction addresses the unmatched translate_off and ensures proper module termination.
  
  // synopsys translate_off
  wire a; // This wire declaration is ignored by the first 'translate_off'
  // synopsys translate_off
  wire b; // This wire declaration is ignored by the second (nested) 'translate_off'
  // synopsys translate_on // Matches the inner 'translate_off'
  // synopsys translate_on // Matches the outer 'translate_off'

endmodule
