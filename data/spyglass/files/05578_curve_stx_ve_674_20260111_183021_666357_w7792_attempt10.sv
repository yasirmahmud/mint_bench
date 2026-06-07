module curve_stx_ve_674_20260111_183021_666357_w7792_attempt10 (
  input p1,
  input p2,
  input p3,
  input p4,
  input p5,
  output out_val,

  input p1, // STX_VE_674: Port name 'p1' previously declared
  input p2, // STX_VE_674: Port name 'p2' previously declared
  input p3, // STX_VE_674: Port name 'p3' previously declared
  input p4, // STX_VE_674: Port name 'p4' previously declared
  input p5  // STX_VE_674: Port name 'p5' previously declared
);

  assign out_val = p1 ^ p2 & p3 | p4 ~^ p5;

endmodule
