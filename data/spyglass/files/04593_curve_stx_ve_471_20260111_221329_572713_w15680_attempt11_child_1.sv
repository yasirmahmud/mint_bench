module curve_stx_ve_471_20260111_221329_572713_w15680_attempt11;

  // This line is intentionally malformed to trigger a STX_VE_471 violation.
  // The Verilog 'localparam' declaration immediately following 'synopsys translate_on'
  // on the same line creates a syntax error, as the pragma expects an end-of-line
  // or another pragma. SpyGlass will report a syntax error after the 'translate_on' token.
  // synopsys translate_on localparam MY_VALUE = 10; // STX_VE_471 triggered here
  // synopsys translate_off // Added to resolve WRN_74: "translate_on specified without associated translate_off"

endmodule
