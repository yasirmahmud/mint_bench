module curve_stx_ve_471_20260111_221329_572713_w15680_attempt12;

  // This line is intentionally malformed to trigger a STX_VE_471 violation.
  // The 'wire' declaration immediately following 'synopsys translate_on'
  // on the same line creates a syntax error for the pragma parser,
  // as it expects an end-of-line or another pragma delimiter after the 'translate_on' token.
  // This example uses a basic 'wire' declaration to ensure a clear syntax error.
  // synopsys translate_on wire my_signal; 

endmodule
