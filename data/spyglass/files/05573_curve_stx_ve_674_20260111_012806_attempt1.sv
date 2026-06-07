module curve_stx_ve_674_20260111_012806_attempt1 (
  input in_a,
  output out_b,
  input in_a // This redeclaration triggers STX_VE_674
);

  assign out_b = in_a;

endmodule
