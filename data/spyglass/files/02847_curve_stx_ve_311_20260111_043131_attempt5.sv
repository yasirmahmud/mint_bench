module curve_stx_ve_311_20260111_043131_attempt5 (
  input wire a,
  input wire b,
  input wire c,
  output wire out
);

  // STX_VE_311: Blocking assignment (a = b) used within a logical expression for a continuous assignment
  assign out = c && (a = b);

endmodule
