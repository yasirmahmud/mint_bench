module curve_stx_ve_471_20260112_005812_728818_w25608_attempt16 (
  input dummy_in,
  output dummy_out
);

  // STX_VE_471: This line triggers the violation.
  // The 'always' keyword immediately after 'translate_on' is an unexpected token.
  // The pragma parser expects the pragma to terminate here.
  // synopsys translate_on always @(*) begin end

  assign dummy_out = dummy_in;

endmodule
