module curve_stx_ve_311_20260111_185556_367397_w47100_attempt10(
  input a,
  input b,
  input c,
  output wire out
);

  // STX_VE_311: Blocking assignment within expression used in continuous assignment
  assign out = c && (a = b);

endmodule
